class Database
{
    void execute(String s) {}
}

class ConnectNotificationMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE ConnectNotification"
              +"connect_notification_uuid TEXT, "
              +"public_key TEXT, "
              +"notified_user_uuid TEXT, "
              +"username TEXT, "
              +"vorname TEXT, "
              +"nachname TEXT, "
              +"photo TEXT, "
              +"thumbnail TEXT, "
              +"description TEXT, "
              +"user_id INTEGER, "
              +"user_uuid TEXT"
            ")"
        );
    }
}
