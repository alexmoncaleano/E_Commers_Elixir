defmodule ECommers.InvoiceProducts do
  @moduledoc """
  The InvoiceProducts context.
  """

  import Ecto.Query, warn: false
  alias ECommers.Repo

  alias ECommers.InvoiceProducts.InvoiceProduct

  @doc """
  Returns the list of invoice_products.

  ## Examples

      iex> list_invoice_products()
      [%InvoiceProduct{}, ...]

  """
  def list_invoice_products do
    Repo.all(InvoiceProduct)
  end

  @doc """
  Gets a single invoice_product.

  Raises `Ecto.NoResultsError` if the Invoice product does not exist.

  ## Examples

      iex> get_invoice_product!(123)
      %InvoiceProduct{}

      iex> get_invoice_product!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invoice_product!(id), do: Repo.get!(InvoiceProduct, id)

  @doc """
  Creates a invoice_product.

  ## Examples

      iex> create_invoice_product(%{field: value})
      {:ok, %InvoiceProduct{}}

      iex> create_invoice_product(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invoice_product(attrs \\ %{}) do
    %InvoiceProduct{}
    |> InvoiceProduct.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invoice_product.

  ## Examples

      iex> update_invoice_product(invoice_product, %{field: new_value})
      {:ok, %InvoiceProduct{}}

      iex> update_invoice_product(invoice_product, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invoice_product(%InvoiceProduct{} = invoice_product, attrs) do
    invoice_product
    |> InvoiceProduct.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invoice_product.

  ## Examples

      iex> delete_invoice_product(invoice_product)
      {:ok, %InvoiceProduct{}}

      iex> delete_invoice_product(invoice_product)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invoice_product(%InvoiceProduct{} = invoice_product) do
    Repo.delete(invoice_product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invoice_product changes.

  ## Examples

      iex> change_invoice_product(invoice_product)
      %Ecto.Changeset{data: %InvoiceProduct{}}

  """
  def change_invoice_product(%InvoiceProduct{} = invoice_product, attrs \\ %{}) do
    InvoiceProduct.changeset(invoice_product, attrs)
  end
end
