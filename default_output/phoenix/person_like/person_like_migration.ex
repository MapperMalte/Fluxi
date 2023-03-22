defmodule FinalLocallity.Repo.Migrations.CreatePersonLike do
  use Ecto.Migration

  def change do
    create table(:person_like) do
      add :person_like_uuid, :string
      add :liked_user_uuid, :string
      add :liking_user_uuid, :string

      timestamps()
    end

  end
end
