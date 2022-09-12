import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnPersonConnected(PersonModel fetchedOrCreatedModel);
typedef OnPersonUpdated(PersonModel updatedModel);

class PersonTeleFactory extends ChangeNotifier
{
  PhoenixChannel? _channel;
  PersonModel syncedInstance;
  String uuid;

  PersonTeleFactory(this.uuid);

  void connect(OnPersonConnected onPersonConnected) async {
    FluxiSocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "model:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (p0) async {
       onPersonConnected(this);
       _channel!.push("init", {
                "uuid": uuid
              }).onReply("ok", (p0) {
                syncedInstance = p0.response['person'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('model:updated') )
                     {
                        syncedInstance = PersonModel.fromMap(message.payload!['person']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(PersonModel newInstance)
  {
    _channel!.push("sync", {
                    "uuid": uuid,
                    "person": newInstance.toMap()
                  });
  }
}
