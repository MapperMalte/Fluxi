defmodule FinalLocallity.ButterBrezelRepo do
  import Ecto.Query, warn: false
  alias FinalLocallity.Repo
  alias FinalLocallity.ButterBrezel

  def create_butter_brezel(attrs \\ %{}) do
    %ButterBrezel{}
    |> ButterBrezel.changeset(attrs)
    |> Repo.insert()
  end

  def get_butter_brezel_by_uuid!(butter_brezel_uuid) do
    Repo.one(from u in ButterBrezel, where: u.butter_brezel_uuid == ^butter_brezel_uuid)
  end

  def update_butter_brezel(%ButterBrezel{} = butter_brezel, attrs) do
    butter_brezel
    |> ButterBrezel.changeset(attrs)
    |> Repo.update()
  end

  def delete_butter_brezel(%ButterBrezel{} = butter_brezel) do
    Repo.delete(butter_brezel)
  end
end
