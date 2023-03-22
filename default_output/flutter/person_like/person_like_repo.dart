class PersonLikeRepo
{
  static Future<int> insertPersonLike(Database database, PersonLikeModel person_likeModel) async
  {
    return await database.insert(PersonLikeModel.TABLE_NAME, person_likeModel.toMap());
  }

  static Future<bool> deletePersonLikeByUUID(Database db, String uuid) async
  {
    return await db.delete(PersonLikeModel.TABLE_NAME,
        where: PersonLikeModel.COLUMN_person_like_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> person_likeExists(Database db, String uuid) async
  {
    return ((await db.query(
                   PersonLikeModel.TABLE_NAME,
                   where: PersonLikeModel.COLUMN_person_like_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<PersonLikeModel?> getPersonLikeByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   PersonLikeModel.TABLE_NAME,
                   where: PersonLikeModel.COLUMN_person_like_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return PersonLikeModel.fromMap(queryResults[0]);
  }
}
