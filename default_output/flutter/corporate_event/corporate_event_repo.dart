class CorporateEventRepo
{
  static Future<int> insertCorporateEvent(Database database, CorporateEventModel corporate_eventModel) async
  {
    return await database.insert(CorporateEventModel.TABLE_NAME, corporate_eventModel.toMap());
  }

  static Future<bool> deleteCorporateEventByUUID(Database db, String uuid) async
  {
    return await db.delete(CorporateEventModel.TABLE_NAME,
        where: CorporateEventModel.COLUMN_corporate_event_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> corporate_eventExists(Database db, String uuid) async
  {
    return ((await db.query(
                   CorporateEventModel.TABLE_NAME,
                   where: CorporateEventModel.COLUMN_corporate_event_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<CorporateEventModel?> getCorporateEventByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   CorporateEventModel.TABLE_NAME,
                   where: CorporateEventModel.COLUMN_corporate_event_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return CorporateEventModel.fromMap(queryResults[0]);
  }
}
