class ButterBrezelRepo
{
  static Future<int> insertButterBrezel(Database database, ButterBrezelModel butter_brezelModel) async
  {
    return await database.insert(ButterBrezelModel.TABLE_NAME, butter_brezelModel.toMap());
  }

  static Future<bool> deleteButterBrezelByUUID(Database db, String uuid) async
  {
    return await db.delete(ButterBrezelModel.TABLE_NAME,
        where: ButterBrezelModel.butter_brezel_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> butter_brezelExists(Database db, String uuid) async
  {
    return ((await db.query(
                   ButterBrezelModel.TABLE_NAME,
                   where: ButterBrezelModel.butter_brezel_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<ButterBrezelModel?> getButterBrezelByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   ButterBrezelModel.TABLE_NAME,
                   where: ButterBrezelModel.butter_brezel_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return ButterBrezelModel.fromMap(queryResults[0]);
  }
}
