defmodule ECommers.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :price, :float
      add :description, :string

      timestamps()
    end
  end
end
