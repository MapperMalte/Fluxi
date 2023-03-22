defmodule FinalLocallity.Repo.Migrations.CreateStory_lobby do
  use Ecto.Migration

  def change do
    create table(:story_lobby) do
      add :story_lobby_uuid, :string
      add :host_user_uuid, :string
      add :title, :string
      add :public, :boolean

      timestamps()
    end

  end
end
