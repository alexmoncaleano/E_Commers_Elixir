defmodule ECommers.Invoices.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoices" do
    field :items, {:array, :map}
    field :price, :float
    field :status, :string
    field :tax, :float
    belongs_to :client, ECommers.Clients.Client
    many_to_many :products, ECommers.Products.Product, join_through: "invoice_products"
    timestamps()
  end

  @doc false
  def changeset(invoice, attrs) do
    invoice
    |> cast(attrs, [:tax, :status, :items, :price, :client_id])
    |> validate_required([:tax, :status, :items, :price, :client_id])
  end
end
