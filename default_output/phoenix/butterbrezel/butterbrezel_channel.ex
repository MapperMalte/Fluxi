defmodule FinalLocallityWeb.ButterBrezelChannel do
  use FinalLocallityWeb, :channel
  alias FinalLocallity.ButterBrezel
  alias FinalLocallity.ButterBrezelRepo

  @impl true
  def join("connect:uuid", %{
    "butter_brezel_uuid" => butter_brezel_uuid
  }, socket) do

    {:ok, socket |> assign( :butter_brezel_uuid, butter_brezel_uuid) }
  end

  @impl true
  def handle_in("init", payload, socket) do
    butter_brezel = ButterBrezelRepo.get_butter_brezel_by_uuid(socket.assigns.butter_brezel_uuid)
    {:reply, {:ok, %{
      "butter_brezel" => butter_brezel
    }}, socket}
  end

  @impl true
  def handle_in("sync", payload, socket) do
    broadcast socket, "model:updated", payload
    {:noreply, socket}
  end

end
