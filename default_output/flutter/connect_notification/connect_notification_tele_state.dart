import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnConnectNotificationConnected(ConnectNotificationModel fetchedOrCreatedModel);
typedef OnConnectNotificationUpdated(ConnectNotificationModel updatedModel);

class ConnectNotificationTeleState extends ChangeNotifier
{
  PhoenixChannel? _channel;
  ConnectNotificationModel syncedInstance;
  String uuid;

  ConnectNotificationTeleState(this.uuid);

  void connect(OnConnectNotificationConnected onConnectNotificationConnected) async {
    ConnectNotificationSocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "connect_notification:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (joinResponse) async {
       onConnectNotificationConnected(this);
       _channel!.push("init", {}).onReply("ok", (initResponse) {
                syncedInstance = initResponse.response['connect_notification'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('connect_notification:updated') )
                     {
                        syncedInstance = ConnectNotificationModel.fromMap(message.payload!['connect_notification']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(ConnectNotificationModel newInstance)
  {
    _channel!.push("sync", {
                    "connect_notification": newInstance.toMap()
                  });
  }
}
