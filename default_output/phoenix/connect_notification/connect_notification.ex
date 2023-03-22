defmodule FinalLocallity.ConnectNotification do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :connect_notification_uuid,
    :public_key,
    :notified_user_uuid,
    :username,
    :vorname,
    :nachname,
    :photo,
    :thumbnail,
    :description,
    :user_id,
    :user_uuid
  ]}
  schema "connect_notification" do
    field :connect_notification_uuid, :string
    field :public_key, :string
    field :notified_user_uuid, :string
    field :username, :string
    field :vorname, :string
    field :nachname, :string
    field :photo, :string
    field :thumbnail, :string
    field :description, :string
    field :user_id, :integer
    field :user_uuid, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:connect_notification_uuid, :public_key, :notified_user_uuid, :username, :vorname, :nachname, :photo, :thumbnail, :description, :user_id, :user_uuid])
    |> validate_required([:connect_notification_uuid, :public_key, :notified_user_uuid, :username, :vorname, :nachname, :photo, :thumbnail, :description, :user_id, :user_uuid])
  end
end
