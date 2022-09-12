class PersonRepo
{
  static Future<int> insertPerson(Database database, PersonModel personModel) async
  {
    return await database.insert(PersonModel.TABLE_NAME, personModel.toMap());
  }

  static Future<bool> deletePersonByUUID(Database db, String uuid) async
  {
    return await db.delete(PersonModel.TABLE_NAME,
        where: PersonModel.person_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> personExists(Database db, String uuid) async
  {
    return ((await db.query(
                   PersonModel.TABLE_NAME,
                   where: PersonModel.person_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<PersonModel?> getPersonByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   PersonModel.TABLE_NAME,
                   where: PersonModel.person_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return PersonModel.fromMap(queryResults[0]);
  }
}
