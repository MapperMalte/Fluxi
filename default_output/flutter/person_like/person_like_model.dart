class PersonLikeModel
{
  static const String TABLE_NAME = 'PersonLike';

  static const String COLUMN_person_like_uuid = "person_like_uuid";
  static const String COLUMN_liked_user_uuid = "liked_user_uuid";
  static const String COLUMN_liking_user_uuid = "liking_user_uuid";

  String? person_like_uuid;
  String? liked_user_uuid;
  String? liking_user_uuid;

  PersonLikeModel.fromMap(Map<dynamic, dynamic> map)
  {
    this.person_like_uuid = map['person_like_uuid'];
    this.liked_user_uuid = map['liked_user_uuid'];
    this.liking_user_uuid = map['liking_user_uuid'];
  }

  Map<String, Object?> toMap() {
    return {
      "person_like_uuid": person_like_uuid,
      "liked_user_uuid": liked_user_uuid,
      "liking_user_uuid": liking_user_uuid
    };
  }


}
