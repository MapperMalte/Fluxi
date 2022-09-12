defmodule FinalLocallityWeb.PersonChannel do
  use FinalLocallityWeb, :channel
  alias FinalLocallity.FinalLocallity.Person

  @impl true
  def join("connect:uuid", %{
    "person_uuid" => person_uuid
  }, socket) do

    {:ok, socket |> assign( :person_uuid, person_uuid) }
  end

  @impl true
  def handle_in("init", payload, socket) do
    person = Feed.get_person_by_uuid(person_uuid)
    {:reply, {:ok, %{
      "person" => person
    }}, socket}
  end

  @impl true
  def handle_in("sync", payload, socket) do
    broadcast socket, "model:updated", payload
    {:noreply, socket}
  end

end
