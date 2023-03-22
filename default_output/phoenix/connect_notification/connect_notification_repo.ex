defmodule FinalLocallity.ConnectNotificationRepo do
  import Ecto.Query, warn: false
  alias FinalLocallity.Repo
  alias FinalLocallity.ConnectNotification

  def create_connect_notification(attrs \\ %{}) do
    %ConnectNotification{}
    |> ConnectNotification.changeset(attrs)
    |> Repo.insert()
  end

  def get_connect_notification_by_uuid!(connect_notification_uuid) do
    Repo.one(from u in ConnectNotification, where: u.connect_notification_uuid == ^connect_notification_uuid)
  end

  def list_each_connect_notification!() do
    Repo.one(from u in ConnectNotification)
  end

  def has_connect_notification_with_uuid!(connect_notification_uuid) do
    Repo.one(from u in ConnectNotification, where: u.connect_notification_uuid == ^connect_notification_uuid)
  end

  def update_connect_notification(%ConnectNotification{} = connect_notification, attrs) do
    connect_notification
    |> ConnectNotification.changeset(attrs)
    |> Repo.update()
  end

  def delete_connect_notification(%ConnectNotification{} = connect_notification) do
    Repo.delete(connect_notification)
  end
end
