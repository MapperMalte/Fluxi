class Database
{
    void execute(String s) {}
}

class PersonMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE Person"
              +"person_uuid TEXT, "
              +"name TEXT, "
              +"age INTEGER"
            ")"
        );
    }
}
