defmodule ECommers.Invoices do
  @moduledoc """
  The Invoices context.
  """

  import Ecto.Query, warn: false
  alias ECommers.Repo
  alias ECommers.Products

  alias ECommers.Invoices.Invoice

  @doc """
  Returns the list of invoices.

  ## Examples

      iex> list_invoices()
      [%Invoice{}, ...]

  """
  def list_invoices do
    Repo.all(Invoice)
    |> Repo.preload(:products)
    |> Repo.preload(:client)
  end

  @doc """
  Gets a single invoice.

  Raises `Ecto.NoResultsError` if the Invoice does not exist.

  ## Examples

      iex> get_invoice!(123)
      %Invoice{}

      iex> get_invoice!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invoice!(id), do:
  Repo.get!(Invoice, id)|> Repo.preload(:products)
  |> Repo.preload(:client)
  |> Repo.preload(:products)



  @doc """
  Creates a invoice.

  ## Examples

      iex> create_invoice(%{field: value})
      {:ok, %Invoice{}}

      iex> create_invoice(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def price(attrs) do

    items = attrs["items"]
    |> Enum.map(fn %{ "product_id" => product_id, "quantity" => quantity } ->
     product = Products.get_product!(product_id)
     %{ product: product, quantity: quantity }
      end)
    total = Float.floor(Enum.reduce(items, 0.0, fn(item, acc) ->
        price = item.product.price
        quantity = item.quantity
        acc + (price * quantity)
      end), 2)
    tax = Float.floor((total * 19) /100, 2)
    %{"client_id" => attrs["client_id"], "items" => attrs["items"],
    "price" => total, "status" => "active", "tax" => tax}
  end

  def create_invoice(attrs \\ %{}) do
    %Invoice{}
    |> Invoice.changeset(price(attrs))
    |> Repo.insert!()
    |> Repo.preload(:client)
    |> Repo.preload(:products)
  end

  def new_item(%Invoice{} = invoice, attrs) do
    ite = invoice.items ++ attrs["items"]
    art = %{"items" => ite}
    { _, invoice} = invoice|> Invoice.changeset(price1(art))|> Repo.update()
    invoice
  end

  def delete_item(%Invoice{} = invoice, attrs) do
    ite = invoice.items -- attrs["items"]
    art = %{"items" => ite}
    { _, invoice} = invoice|> Invoice.changeset(price1(art))|> Repo.update()
    invoice
  end

  def pay_invoice(%Invoice{} = invoice) do
    statu = %{"status" => "paid"}
    { _, invoice} = invoice|> Invoice.changeset(statu)|> Repo.update()
    invoice
  end
  @doc """
  Updates a invoice.

  ## Examples

      iex> update_invoice(invoice, %{field: new_value})
      {:ok, %Invoice{}}

      iex> update_invoice(invoice, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invoice(%Invoice{} = invoice, attrs) do
    invoice
    |> Invoice.changeset(price(attrs))
    |> Repo.update()
  end

  @doc """
  Deletes a invoice.

  ## Examples

      iex> delete_invoice(invoice)
      {:ok, %Invoice{}}

      iex> delete_invoice(invoice)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invoice(%Invoice{} = invoice) do
    Repo.delete(invoice)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice changes.

  ## Examples

      iex> change_invoice(invoice)
      %Ecto.Changeset{data: %Invoice{}}

  """
  def change_invoice(%Invoice{} = invoice, attrs \\ %{}) do
    Invoice.changeset(invoice, attrs)
  end

  def price1(attrs) do

    items = attrs["items"]
    |> Enum.map(fn %{ "product_id" => product_id, "quantity" => quantity } ->
     product = Products.get_product!(product_id)
     %{ product: product, quantity: quantity }
      end)
    total = Float.floor(Enum.reduce(items, 0.0, fn(item, acc) ->
        price = item.product.price
        quantity = item.quantity
        acc + (price * quantity)
      end), 2)
    tax = Float.floor((total * 19) /100, 2)
    %{"items" => attrs["items"],
    "price" => total,  "tax" => tax}
  end
end
