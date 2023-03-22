defmodule FinalLocallityWeb.ConnectNotificationChannel do
  use FinalLocallityWeb, :channel
  alias FinalLocallity.ConnectNotification
  alias FinalLocallity.ConnectNotificationRepo

  @impl true
  def join("connect_notification:lobby", params, socket) do
    ConnectNotificationRepo.list_each_connect_notification!()
    {:ok, socket |> assign( :connect_notification_uuid, uuid) }
  end

  @impl true
  def join("connect_notification:"<>uuid, params, socket) do
    {:ok, socket |> assign( :connect_notification_uuid, uuid) }
  end

  @impl true
  def handle_in("init", payload, socket) do
    connect_notification = ConnectNotificationRepo.get_connect_notification_by_uuid(socket.assigns.connect_notification_uuid)
    {:reply, {:ok, %{
      "connect_notification" => connect_notification
    }}, socket}
  end

  @impl true
  def handle_in("sync", connect_notification = %{
    connect_notification_uuid => connect_notification_uuid,
    public_key => public_key,
    notified_user_uuid => notified_user_uuid,
    username => username,
    vorname => vorname,
    nachname => nachname,
    photo => photo,
    thumbnail => thumbnail,
    description => description,
    user_id => user_id,
    user_uuid => user_uuid
  }, socket) do
    if ( ConnectNotificationRepo.has_connect_notification_with_uuid!(connect_notification_uuid) ) do
        existing_connect_notification = ConnectNotificationRepo.get_connect_notification_by_uuid!(connect_notification_uuid)
            ConnectNotificationRepo.update_connect_notification_by_uuid(
                existing_connect_notification,
                connect_notification
            )
        broadcast socket, "model:updated", connect_notification
    else
        case ConnectNotificationRepo.create_connect_notification(connect_notification) do
              {:ok, newly_created_connect_notification} ->
                broadcast socket, "model:created", newly_created_connect_notification
              {:error, %Ecto.Changeset{} = changeset} ->
        end
    end
    {:noreply, socket}
  end

end
