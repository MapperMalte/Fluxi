class Story_lobbyRepo
{
  static Future<int> insertStory_lobby(Database database, Story_lobbyModel story_lobbyModel) async
  {
    return await database.insert(Story_lobbyModel.TABLE_NAME, story_lobbyModel.toMap());
  }

  static Future<bool> deleteStory_lobbyByUUID(Database db, String uuid) async
  {
    return await db.delete(Story_lobbyModel.TABLE_NAME,
        where: Story_lobbyModel.COLUMN_story_lobby_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> story_lobbyExists(Database db, String uuid) async
  {
    return ((await db.query(
                   Story_lobbyModel.TABLE_NAME,
                   where: Story_lobbyModel.COLUMN_story_lobby_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<Story_lobbyModel?> getStory_lobbyByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   Story_lobbyModel.TABLE_NAME,
                   where: Story_lobbyModel.COLUMN_story_lobby_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return Story_lobbyModel.fromMap(queryResults[0]);
  }
}
