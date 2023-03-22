defmodule FinalLocallity.PersonLike do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :person_like_uuid, 
    :liked_user_uuid, 
    :liking_user_uuid
  ]}
  schema "person_like" do
    field :person_like_uuid, :string
    field :liked_user_uuid, :string
    field :liking_user_uuid, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:person_like_uuid, :liked_user_uuid, :liking_user_uuid])
    |> validate_required([:person_like_uuid, :liked_user_uuid, :liking_user_uuid])
  end
end
