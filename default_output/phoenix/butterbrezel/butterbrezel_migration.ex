defmodule FinalLocallity.Repo.Migrations.CreateButterBrezel do
  use Ecto.Migration

  def change do
    create table(:butter_brezel) do
      add :butter_brezel_uuid, :string
      add :age, :integer
      add :weight, :integer
      add :name, :string

      timestamps()
    end

  end
end
