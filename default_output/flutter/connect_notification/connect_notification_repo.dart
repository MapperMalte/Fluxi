class ConnectNotificationRepo
{
  static Future<int> insertConnectNotification(Database database, ConnectNotificationModel connect_notificationModel) async
  {
    return await database.insert(ConnectNotificationModel.TABLE_NAME, connect_notificationModel.toMap());
  }

  static Future<bool> deleteConnectNotificationByUUID(Database db, String uuid) async
  {
    return await db.delete(ConnectNotificationModel.TABLE_NAME,
        where: ConnectNotificationModel.COLUMN_connect_notification_uuid+ " = ?",
        whereArgs: [uuid]);
  }

  static Future<bool> connect_notificationExists(Database db, String uuid) async
  {
    return ((await db.query(
                   ConnectNotificationModel.TABLE_NAME,
                   where: ConnectNotificationModel.COLUMN_connect_notification_uuid+ " = ? ",
                   whereArgs: [uuid],
                   limit: 1
               )).length > 0);
  }

  static Future<ConnectNotificationModel?> getConnectNotificationByUUID(Database db, String uuid) async
  {
    List<Map> queryResults = (await db.query(
                   ConnectNotificationModel.TABLE_NAME,
                   where: ConnectNotificationModel.COLUMN_connect_notification_uuid+ " = ? ",
                   whereArgs: [uuid],
               ));
    return ConnectNotificationModel.fromMap(queryResults[0]);
  }
}
