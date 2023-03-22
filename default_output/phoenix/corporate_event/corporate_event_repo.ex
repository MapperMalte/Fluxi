defmodule FinalLocallity.CorporateEventRepo do
  import Ecto.Query, warn: false
  alias FinalLocallity.Repo
  alias FinalLocallity.CorporateEvent

  def create_corporate_event(attrs \\ %{}) do
    %CorporateEvent{}
    |> CorporateEvent.changeset(attrs)
    |> Repo.insert()
  end

  def get_corporate_event_by_uuid!(corporate_event_uuid) do
    Repo.one(from u in CorporateEvent, where: u.corporate_event_uuid == ^corporate_event_uuid)
  end

  def list_each_corporate_event!() do
    Repo.one(from u in CorporateEvent)
  end

  def has_corporate_event_with_uuid!(corporate_event_uuid) do
    Repo.one(from u in CorporateEvent, where: u.corporate_event_uuid == ^corporate_event_uuid)
  end

  def update_corporate_event(%CorporateEvent{} = corporate_event, attrs) do
    corporate_event
    |> CorporateEvent.changeset(attrs)
    |> Repo.update()
  end

  def delete_corporate_event(%CorporateEvent{} = corporate_event) do
    Repo.delete(corporate_event)
  end
end
