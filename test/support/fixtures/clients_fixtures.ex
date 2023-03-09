defmodule ECommers.ClientsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ECommers.Clients` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        address: "some address",
        doc_type: "some doc_type",
        email: "some email",
        first_name: "some first_name",
        id_number: "some id_number",
        last_name: "some last_name",
        phone: "some phone"
      })
      |> ECommers.Clients.create_client()

    client
  end
end
