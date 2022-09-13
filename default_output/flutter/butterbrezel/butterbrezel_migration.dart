class Database
{
    void execute(String s) {}
}

class ButterBrezelMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE ButterBrezel"
              +"butter_brezel_uuid TEXT, "
              +"age INTEGER, "
              +"weight INTEGER, "
              +"name TEXT"
            ")"
        );
    }
}
