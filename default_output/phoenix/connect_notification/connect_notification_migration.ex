defmodule FinalLocallity.Repo.Migrations.CreateConnectNotification do
  use Ecto.Migration

  def change do
    create table(:connect_notification) do
      add :connect_notification_uuid, :string
      add :public_key, :string
      add :notified_user_uuid, :string
      add :username, :string
      add :vorname, :string
      add :nachname, :string
      add :photo, :string
      add :thumbnail, :string
      add :description, :string
      add :user_id, :integer
      add :user_uuid, :string

      timestamps()
    end

  end
end
