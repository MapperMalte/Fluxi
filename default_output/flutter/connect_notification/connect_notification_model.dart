class ConnectNotificationModel
{
  static const String TABLE_NAME = 'ConnectNotification';

  static const String COLUMN_connect_notification_uuid = "connect_notification_uuid";
  static const String COLUMN_public_key = "public_key";
  static const String COLUMN_notified_user_uuid = "notified_user_uuid";
  static const String COLUMN_username = "username";
  static const String COLUMN_vorname = "vorname";
  static const String COLUMN_nachname = "nachname";
  static const String COLUMN_photo = "photo";
  static const String COLUMN_thumbnail = "thumbnail";
  static const String COLUMN_description = "description";
  static const String COLUMN_user_id = "user_id";
  static const String COLUMN_user_uuid = "user_uuid";

  String? connect_notification_uuid;
  String? public_key;
  String? notified_user_uuid;
  String? username;
  String? vorname;
  String? nachname;
  String? photo;
  String? thumbnail;
  String? description;
  int? user_id;
  String? user_uuid;

  ConnectNotificationModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.connect_notification_uuid = map['connect_notification_uuid'];
    this.public_key = map['public_key'];
    this.notified_user_uuid = map['notified_user_uuid'];
    this.username = map['username'];
    this.vorname = map['vorname'];
    this.nachname = map['nachname'];
    this.photo = map['photo'];
    this.thumbnail = map['thumbnail'];
    this.description = map['description'];
    this.user_id = map['user_id'];
    this.user_uuid = map['user_uuid'];
  }

  Map<String, Object?> toMap() {
    return {
      "connect_notification_uuid": connect_notification_uuid,
      "public_key": public_key,
      "notified_user_uuid": notified_user_uuid,
      "username": username,
      "vorname": vorname,
      "nachname": nachname,
      "photo": photo,
      "thumbnail": thumbnail,
      "description": description,
      "user_id": user_id,
      "user_uuid": user_uuid
    };
  }


}
