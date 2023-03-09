defmodule ECommers.InvoiceProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ECommers.InvoiceProducts` context.
  """

  @doc """
  Generate a invoice_product.
  """
  def invoice_product_fixture(attrs \\ %{}) do
    {:ok, invoice_product} =
      attrs
      |> Enum.into(%{
        quantity: 42
      })
      |> ECommers.InvoiceProducts.create_invoice_product()

    invoice_product
  end
end
