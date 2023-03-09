defmodule ECommersWeb.InvoiceProductJSON do
  alias ECommers.InvoiceProducts.InvoiceProduct

  @doc """
  Renders a list of invoice_products.
  """
  def index(%{invoice_products: invoice_products}) do
    %{data: for(invoice_product <- invoice_products, do: data(invoice_product))}
  end

  @doc """
  Renders a single invoice_product.
  """
  def show(%{invoice_product: invoice_product}) do
    %{data: data(invoice_product)}
  end

  defp data(%InvoiceProduct{} = invoice_product) do
    %{
      id: invoice_product.id,
      quantity: invoice_product.quantity
    }
  end
end
