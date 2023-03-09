defmodule ECommersWeb.InvoiceJSON do
  alias ECommers.Invoices.Invoice
  alias ECommers.Clients
  alias ECommers.Products

  @doc """
  Renders a list of invoices.
  """
  def index(%{invoices: invoices}) do
    %{data: for(invoice <- invoices, do: data(invoice))}
  end

  @doc """
  Renders a single invoice.
  """
  def show(%{invoice: invoice}) do
    %{data: data(invoice)}
  end

  defp data(%Invoice{} = invoice) do
    #IO.inspect(invoice)
    #client = [invoice.client]
    #|> Enum.map(& Map.from_struct(&1))
    #|> Enum.map(& Enum.reduce([:__meta__, :invoices, :inserted_at, :updated_at],
    #&1, fn key, acc -> Map.delete(acc,key) end))
    drop_list = [:__meta__, :__struct__, :invoices, :inserted_at, :updated_at]
    #client = invoice.client |> Map.drop(drop_list)
    client = Clients.get_client!(invoice.client_id)

    #items = Enum.map(invoice.items, fn %{product_id: product_id, quantity: quantity} ->
    #  product = Products.get_product!(product_id) |> Map.drop(drop_list)
    IO.puts("**********************************************************")
    items = invoice.items
      |> Enum.map(fn %{ "product_id" => product_id, "quantity" => quantity } ->
       product = Products.get_product!(product_id) |> Map.drop(drop_list)
       %{ product: product, quantity: quantity }
        end)
    %{
      id: invoice.id,
      tax: invoice.tax,
      status: invoice.status,
      items: items,
      price: invoice.price,
      client: %{
        id_number: client.id_number,
        first_name: client.first_name,
        last_name: client.last_name,
        phone: client.phone,
        email: client.email,
        address: client.address,
        doc_type: client.doc_type
      }
    }
  end
end
