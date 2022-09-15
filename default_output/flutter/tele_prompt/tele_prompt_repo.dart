import 'tele_prompt_model.dart';

class TelePromptRepo
{
  static Future<int> insertTelePrompt(Database database, TelePromptModel tele_promptModel) async
  {
    return await database.insert(TelePromptModel.TABLE_NAME, tele_promptModel.toMap());
  }

  static Future<bool> deleteTelePromptByUUID(Database db, String uuid) async
  {
    return await db.delete(TelePromptModel.TABLE_NAME,
        where: TelePromptModel.COLUMN_tele_prompt_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> tele_promptExists(Database db, String uuid) async
  {
    return ((await db.query(
                   TelePromptModel.TABLE_NAME,
                   where: TelePromptModel.COLUMN_tele_prompt_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<TelePromptModel?> getTelePromptByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   TelePromptModel.TABLE_NAME,
                   where: TelePromptModel.COLUMN_tele_prompt_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return TelePromptModel.fromMap(queryResults[0]);
  }
}
