defmodule ECommers.InvoiceProducts.InvoiceProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "invoice_products" do
    field :quantity, :integer
    field :invoice_id, :binary_id
    field :product_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(invoice_product, attrs) do
    invoice_product
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
