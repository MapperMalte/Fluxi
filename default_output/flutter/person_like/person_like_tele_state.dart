import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnPersonLikeConnected(PersonLikeModel fetchedOrCreatedModel);
typedef OnPersonLikeUpdated(PersonLikeModel updatedModel);

class PersonLikeTeleState extends ChangeNotifier
{
  PhoenixChannel? _channel;
  PersonLikeModel syncedInstance;
  String uuid;

  PersonLikeTeleState(this.uuid);

  void connect(OnPersonLikeConnected onPersonLikeConnected) async {
    PersonLikeSocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "person_like:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (joinResponse) async {
       onPersonLikeConnected(this);
       _channel!.push("init", {}).onReply("ok", (initResponse) {
                syncedInstance = initResponse.response['person_like'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('person_like:updated') )
                     {
                        syncedInstance = PersonLikeModel.fromMap(message.payload!['person_like']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(PersonLikeModel newInstance)
  {
    _channel!.push("sync", {
                    "person_like": newInstance.toMap()
                  });
  }
}
