class Database
{
    void execute(String s) {}
}

class PersonLikeMigration
{
    void createDatabase(Database db)
    {
        db.execute("CREATE TABLE PersonLike"
              +"person_like_uuid TEXT, "
              +"liked_user_uuid TEXT, "
              +"liking_user_uuid TEXT"
            ")"
        );
    }
}
