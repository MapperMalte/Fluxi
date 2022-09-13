defmodule FinalLocallity.ButterBrezel do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [
    :butter_brezel_uuid, 
    :age, 
    :weight, 
    :name
  ]}
  schema "butter_brezel" do

    field :butter_brezel_uuid, :string
    field :age, :integer
    field :weight, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [:butter_brezel_uuid, :age, :weight, :name])
    |> validate_required([:butter_brezel_uuid, :age, :weight, :name])
  end
end
