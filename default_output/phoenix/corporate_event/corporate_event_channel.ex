defmodule FinalLocallityWeb.CorporateEventChannel do
  use FinalLocallityWeb, :channel
  alias FinalLocallity.CorporateEvent
  alias FinalLocallity.CorporateEventRepo

  @impl true
  def join("corporate_event:lobby", params, socket) do
    CorporateEventRepo.list_each_corporate_event!()
    {:ok, socket |> assign( :corporate_event_uuid, uuid) }
  end

  @impl true
  def join("corporate_event:"<>uuid, params, socket) do
    {:ok, socket |> assign( :corporate_event_uuid, uuid) }
  end

  @impl true
  def handle_in("init", payload, socket) do
    corporate_event = CorporateEventRepo.get_corporate_event_by_uuid(socket.assigns.corporate_event_uuid)
    {:reply, {:ok, %{
      "corporate_event" => corporate_event
    }}, socket}
  end

  @impl true
  def handle_in("sync", corporate_event = %{
    corporate_event_uuid => corporate_event_uuid, 
    title => title, 
    description => description, 
    date => date, 
    einlass => einlass, 
    preis => preis
  }, socket) do
    if ( CorporateEventRepo.has_corporate_event_with_uuid!(corporate_event_uuid) ) do
        existing_corporate_event = CorporateEventRepo.get_corporate_event_by_uuid!(corporate_event_uuid)
            CorporateEventRepo.update_corporate_event_by_uuid(
                existing_corporate_event,
                corporate_event
            )
        broadcast socket, "model:updated", corporate_event
    else
        case CorporateEventRepo.create_corporate_event(corporate_event) do
              {:ok, newly_created_corporate_event} ->
                broadcast socket, "model:created", newly_created_corporate_event
              {:error, %Ecto.Changeset{} = changeset} ->
        end
    end
    {:noreply, socket}
  end

end
