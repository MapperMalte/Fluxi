import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnTelePromptConnected(TelePromptModel fetchedOrCreatedModel);
typedef OnTelePromptUpdated(TelePromptModel updatedModel);

class TelePromptTeleFactory extends ChangeNotifier
{
  PhoenixChannel? _channel;
  TelePromptModel syncedInstance;
  String uuid;

  TelePromptTeleFactory(this.uuid);

  void connect(OnTelePromptConnected onTelePromptConnected) async {
    TelePromptSocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "tele_prompt:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (joinResponse) async {
       onTelePromptConnected(this);
       _channel!.push("init", {}).onReply("ok", (initResponse) {
                syncedInstance = initResponse.response['tele_prompt'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('tele_prompt:updated') )
                     {
                        syncedInstance = TelePromptModel.fromMap(message.payload!['tele_prompt']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(TelePromptModel newInstance)
  {
    _channel!.push("sync", {
                    "uuid": uuid,
                    "tele_prompt": newInstance.toMap()
                  });
  }
}
