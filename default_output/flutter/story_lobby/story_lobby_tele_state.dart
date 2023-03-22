import 'package:flutter/cupertino.dart';
import 'package:locallity/model_refactored/connection_models/socket_instance.dart';
import 'package:phoenix_socket/phoenix_socket.dart';

typedef OnStory_lobbyConnected(Story_lobbyModel fetchedOrCreatedModel);
typedef OnStory_lobbyUpdated(Story_lobbyModel updatedModel);

class Story_lobbyTeleState extends ChangeNotifier
{
  PhoenixChannel? _channel;
  Story_lobbyModel syncedInstance;
  String uuid;

  Story_lobbyTeleState(this.uuid);

  void connect(OnStory_lobbyConnected onStory_lobbyConnected) async {
    Story_lobbySocketInstance.getInstance().enqueue((phoenixSocket) async {
      _channel = phoenixSocket.addChannel(
          topic: "story_lobby:"+uuid,
          parameters: {}
      );
     _channel?.join().onReply("ok", (joinResponse) async {
       onStory_lobbyConnected(this);
       _channel!.push("init", {}).onReply("ok", (initResponse) {
                syncedInstance = initResponse.response['story_lobby'];
                notifyListeners();
                await for (var message in _channel!.messages) {
                     if (message.event == PhoenixChannelEvent.custom('story_lobby:updated') )
                     {
                        syncedInstance = Story_lobbyModel.fromMap(message.payload!['story_lobby']);
                        notifyListeners();
                     }
                }
              });
      });
    });
  }

  void sync(Story_lobbyModel newInstance)
  {
    _channel!.push("sync", {
                    "story_lobby": newInstance.toMap()
                  });
  }
}
