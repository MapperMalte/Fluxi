defmodule FinalLocallity.Story_lobby do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :story_lobby_uuid, 
    :host_user_uuid, 
    :title, 
    :public
  ]}
  schema "story_lobby" do
    field :story_lobby_uuid, :string
    field :host_user_uuid, :string
    field :title, :string
    field :public, :boolean

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:story_lobby_uuid, :host_user_uuid, :title, :public])
    |> validate_required([:story_lobby_uuid, :host_user_uuid, :title, :public])
  end
end
