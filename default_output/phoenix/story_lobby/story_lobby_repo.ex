defmodule FinalLocallity.Story_lobbyRepo do
  import Ecto.Query, warn: false
  alias FinalLocallity.Repo
  alias FinalLocallity.Story_lobby

  def create_story_lobby(attrs \\ %{}) do
    %Story_lobby{}
    |> Story_lobby.changeset(attrs)
    |> Repo.insert()
  end

  def get_story_lobby_by_uuid!(story_lobby_uuid) do
    Repo.one(from u in Story_lobby, where: u.story_lobby_uuid == ^story_lobby_uuid)
  end

  def list_each_story_lobby!() do
    Repo.one(from u in Story_lobby)
  end

  def has_story_lobby_with_uuid!(story_lobby_uuid) do
    Repo.one(from u in Story_lobby, where: u.story_lobby_uuid == ^story_lobby_uuid)
  end

  def update_story_lobby(%Story_lobby{} = story_lobby, attrs) do
    story_lobby
    |> Story_lobby.changeset(attrs)
    |> Repo.update()
  end

  def delete_story_lobby(%Story_lobby{} = story_lobby) do
    Repo.delete(story_lobby)
  end
end
