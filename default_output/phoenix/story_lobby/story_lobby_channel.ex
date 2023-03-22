defmodule FinalLocallityWeb.Story_lobbyChannel do
  use FinalLocallityWeb, :channel
  alias FinalLocallity.Story_lobby
  alias FinalLocallity.Story_lobbyRepo

  @impl true
  def join("story_lobby:lobby", params, socket) do
    Story_lobbyRepo.list_each_story_lobby!()
    {:ok, socket |> assign( :story_lobby_uuid, uuid) }
  end

  @impl true
  def join("story_lobby:"<>uuid, params, socket) do
    {:ok, socket |> assign( :story_lobby_uuid, uuid) }
  end

  @impl true
  def handle_in("init", payload, socket) do
    story_lobby = Story_lobbyRepo.get_story_lobby_by_uuid(socket.assigns.story_lobby_uuid)
    {:reply, {:ok, %{
      "story_lobby" => story_lobby
    }}, socket}
  end

  @impl true
  def handle_in("sync", story_lobby = %{
    story_lobby_uuid => story_lobby_uuid, 
    host_user_uuid => host_user_uuid, 
    title => title, 
    public => public
  }, socket) do
    if ( Story_lobbyRepo.has_story_lobby_with_uuid!(story_lobby_uuid) ) do
        existing_story_lobby = Story_lobbyRepo.get_story_lobby_by_uuid!(story_lobby_uuid)
            Story_lobbyRepo.update_story_lobby_by_uuid(
                existing_story_lobby,
                story_lobby
            )
        broadcast socket, "model:updated", story_lobby
    else
        case Story_lobbyRepo.create_story_lobby(story_lobby) do
              {:ok, newly_created_story_lobby} ->
                broadcast socket, "model:created", newly_created_story_lobby
              {:error, %Ecto.Changeset{} = changeset} ->
        end
    end
    {:noreply, socket}
  end

end
