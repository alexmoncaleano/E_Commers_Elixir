defmodule ECommers.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :id_number, :string
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :email, :string
      add :address, :string
      add :doc_type, :string

      timestamps()
    end

    create unique_index(:clients, [:id_number])
  end
end
