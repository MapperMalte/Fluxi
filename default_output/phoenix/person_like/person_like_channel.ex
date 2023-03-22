defmodule FinalLocallityWeb.PersonLikeChannel do
  use FinalLocallityWeb, :channel
  alias FinalLocallity.PersonLike
  alias FinalLocallity.PersonLikeRepo

  @impl true
  def join("person_like:lobby", params, socket) do
    PersonLikeRepo.list_each_person_like!()
    {:ok, socket |> assign( :person_like_uuid, uuid) }
  end

  @impl true
  def join("person_like:"<>uuid, params, socket) do
    {:ok, socket |> assign( :person_like_uuid, uuid) }
  end

  @impl true
  def handle_in("init", payload, socket) do
    person_like = PersonLikeRepo.get_person_like_by_uuid(socket.assigns.person_like_uuid)
    {:reply, {:ok, %{
      "person_like" => person_like
    }}, socket}
  end

  @impl true
  def handle_in("sync", person_like = %{
    person_like_uuid => person_like_uuid,
    liked_user_uuid => liked_user_uuid,
    liking_user_uuid => liking_user_uuid
  }, socket) do
    if ( PersonLikeRepo.has_person_like_with_uuid!(person_like_uuid) ) do
        existing_person_like = PersonLikeRepo.get_person_like_by_uuid!(person_like_uuid)
            PersonLikeRepo.update_person_like_by_uuid(
                existing_person_like,
                person_like
            )
        broadcast socket, "model:updated", person_like
    else
        case PersonLikeRepo.create_person_like(person_like) do
              {:ok, newly_created_person_like} ->
                broadcast socket, "model:created", newly_created_person_like
              {:error, %Ecto.Changeset{} = changeset} ->
        end
    end
    {:noreply, socket}
  end

end
