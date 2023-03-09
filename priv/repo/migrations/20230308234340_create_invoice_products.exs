defmodule ECommers.Repo.Migrations.CreateInvoiceProducts do
  use Ecto.Migration

  def change do
    create table(:invoice_products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :invoice_id, references(:invoices, on_delete: :nothing, type: :binary_id)
      add :product_id, references(:products, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:invoice_products, [:invoice_id])
    create index(:invoice_products, [:product_id])
  end
end
