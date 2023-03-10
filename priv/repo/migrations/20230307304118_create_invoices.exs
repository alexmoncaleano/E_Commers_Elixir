defmodule ECommers.Repo.Migrations.CreateInvoices do
  use Ecto.Migration

  def change do
    create table(:invoices, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :tax, :float
      add :status, :string
      add :items, {:array, :map}
      add :price, :float
      add :client_id, references(:clients, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:invoices, [:client_id])
  end
end
