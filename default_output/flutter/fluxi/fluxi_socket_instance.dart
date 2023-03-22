import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnFluxiSocketInstanceOpened(PhoenixSocket phoenixSocket);

class FluxiSocketInstance
{
  static FluxiSocketInstance? _socketInstance;
  bool connecting = false;
  bool connected = false;
  PhoenixSocket? phoenixSocket;
  List<OnFluxiSocketInstanceOpened> awaitingClients = [];

  static FluxiSocketInstance getInstance()
  {
    if ( _socketInstance == null )
    {
      _socketInstance = new FluxiSocketInstance();
      _socketInstance!.connect();
    }
    return _socketInstance!;
  }

  void connect()
  {
    if ( connecting || connected ) return;
    connecting = true;

    phoenixSocket = PhoenixSocket(
        'wss://' +  TeleRepo.TELE_URL   +'/socket/websocket',
        socketOptions: PhoenixSocketOptions (
                params: {
                  "token": Myself.token
                },
                timeout: Duration(seconds: 25)
            )
    );

    phoenixSocket!.closeStream.listen((event) {
      connected = false;
    });

    phoenixSocket!.openStream.listen((event) async {
      connecting = false;
      connected = true;
      for(int i = 0; i < awaitingClients.length; i++)
      {
        awaitingClients[i](phoenixSocket!);
      }
    });
  }

  void enqueue(OnFluxiSocketInstanceOpened onFluxiSocketInstanceOpened)
  {
    if ( connected )
    {
      onFluxiSocketInstanceOpened(phoenixSocket!);
    } else {
      awaitingClients.add(onFluxiSocketInstanceOpened);
    }
  }
}
