class Story_lobbyModel
{
  static const String TABLE_NAME = 'Story_lobby';

  static const String COLUMN_story_lobby_uuid = "story_lobby_uuid";
  static const String COLUMN_host_user_uuid = "host_user_uuid";
  static const String COLUMN_title = "title";
  static const String COLUMN_public = "public";

  String? story_lobby_uuid;
  String? host_user_uuid;
  String? title;
  bool? public;

  Story_lobbyModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.story_lobby_uuid = map['story_lobby_uuid'];
    this.host_user_uuid = map['host_user_uuid'];
    this.title = map['title'];
    this.public = map['public'];
  }

  Map<String, Object?> toMap() {
    return {
      "story_lobby_uuid": story_lobby_uuid,
      "host_user_uuid": host_user_uuid,
      "title": title,
      "public": public
    };
  }


}
