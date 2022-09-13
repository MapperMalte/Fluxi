import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnButterBrezelConnected(ButterBrezelModel fetchedOrCreatedModel);
typedef OnButterBrezelUpdated(ButterBrezelModel updatedModel);

class ButterBrezelTeleFactory extends ChangeNotifier
{
  PhoenixChannel? _channel;
  ButterBrezelModel syncedInstance;
  String uuid;

  ButterBrezelTeleFactory(this.uuid);

  void connect(OnButterBrezelConnected onButterBrezelConnected) async {
    FluxiSocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "model:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (p0) async {
       onButterBrezelConnected(this);
       _channel!.push("init", {
                "uuid": uuid
              }).onReply("ok", (p0) {
                syncedInstance = p0.response['butter_brezel'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('model:updated') )
                     {
                        syncedInstance = ButterBrezelModel.fromMap(message.payload!['butter_brezel']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(ButterBrezelModel newInstance)
  {
    _channel!.push("sync", {
                    "uuid": uuid,
                    "butter_brezel": newInstance.toMap()
                  });
  }
}
