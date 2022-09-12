defmodule FinalLocallity.Person do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :person_uuid, 
    :name, 
    :age
  ]}
  schema "person" do

    field :person_uuid, :string
    field :name, :string
    field :age, :integer

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:person_uuid, :name, :age])
    |> validate_required([:person_uuid, :name, :age])
  end
end
