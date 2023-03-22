class Database
{
    void execute(String s) {}
}

class Story_lobbyMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE Story_lobby"
              +"story_lobby_uuid TEXT, "
              +"host_user_uuid TEXT, "
              +"title TEXT, "
              +"public --UNKNOWN TYPE--"
            ")"
        );
    }
}
