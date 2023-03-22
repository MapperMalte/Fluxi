import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnCorporateEventConnected(CorporateEventModel fetchedOrCreatedModel);
typedef OnCorporateEventUpdated(CorporateEventModel updatedModel);

class CorporateEventTeleState extends ChangeNotifier
{
  PhoenixChannel? _channel;
  CorporateEventModel syncedInstance;
  String uuid;

  CorporateEventTeleState(this.uuid);

  void connect(OnCorporateEventConnected onCorporateEventConnected) async {
    CorporateEventSocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "corporate_event:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (joinResponse) async {
       onCorporateEventConnected(this);
       _channel!.push("init", {}).onReply("ok", (initResponse) {
                syncedInstance = initResponse.response['corporate_event'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('corporate_event:updated') )
                     {
                        syncedInstance = CorporateEventModel.fromMap(message.payload!['corporate_event']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(CorporateEventModel newInstance)
  {
    _channel!.push("sync", {
                    "corporate_event": newInstance.toMap()
                  });
  }
}
