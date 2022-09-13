class Database
{
    void execute(String s) {}
}

class TelePromptListMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE TelePromptList"
              +"tele_prompt_list_uuid TEXT, "
              +"name TEXT, "
              +"owner TEXT"
            ")"
        );
    }
}
