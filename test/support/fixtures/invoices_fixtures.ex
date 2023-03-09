defmodule ECommers.InvoicesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ECommers.Invoices` context.
  """

  @doc """
  Generate a invoice.
  """
  def invoice_fixture(attrs \\ %{}) do
    {:ok, invoice} =
      attrs
      |> Enum.into(%{
        items: [],
        price: 120.5,
        status: "some status",
        tax: 120.5
      })
      |> ECommers.Invoices.create_invoice()

    invoice
  end
end
