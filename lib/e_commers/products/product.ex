defmodule ECommers.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :description, :string
    field :name, :string
    field :price, :float
    many_to_many :invoices, ECommers.Invoices.Invoice, join_through: "invoice_products"

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :description])
    |> validate_required([:name, :price, :description])
  end
end
