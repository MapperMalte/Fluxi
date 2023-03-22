defmodule FinalLocallity.PersonLikeRepo do
  import Ecto.Query, warn: false
  alias FinalLocallity.Repo
  alias FinalLocallity.PersonLike

  def create_person_like(attrs \\ %{}) do
    %PersonLike{}
    |> PersonLike.changeset(attrs)
    |> Repo.insert()
  end

  def get_person_like_by_uuid!(person_like_uuid) do
    Repo.one(from u in PersonLike, where: u.person_like_uuid == ^person_like_uuid)
  end

  def list_each_person_like!() do
    Repo.one(from u in PersonLike)
  end

  def has_person_like_with_uuid!(person_like_uuid) do
    Repo.one(from u in PersonLike, where: u.person_like_uuid == ^person_like_uuid)
  end

  def update_person_like(%PersonLike{} = person_like, attrs) do
    person_like
    |> PersonLike.changeset(attrs)
    |> Repo.update()
  end

  def delete_person_like(%PersonLike{} = person_like) do
    Repo.delete(person_like)
  end
end
