class Database
{
    void execute(String s) {}
}

class TelePromptMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE TelePrompt"
              +"tele_prompt_uuid TEXT, "
              +"name TEXT, "
              +"age INTEGER"
            ")"
        );
    }
}
