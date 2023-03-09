defmodule ECommers.Clients.Client do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :address, :string
    field :doc_type, :string
    field :email, :string
    field :first_name, :string
    field :id_number, :string
    field :last_name, :string
    field :phone, :string
    has_many :invoices, ECommers.Invoices.Invoice


    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:id_number, :first_name, :last_name, :phone, :email, :address, :doc_type])
    |> validate_required([:id_number, :first_name, :last_name, :phone, :email, :address, :doc_type])
    |> validate_length(:phone, is: 10, message: "must be 10 digits")
    |> validate_format(:id_number, ~r/^\d+$/, message: "must contain only numbers")
    |> validate_format(:first_name, ~r/^[a-zA-Z]+$/, message: "must contain only letters")
    |> validate_format(:last_name, ~r/^[a-zA-Z]+$/, message: "must contain only letters")
    |> validate_format(:email, ~r/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "must be a valid email")
    |> unique_constraint(:id_number, message: "user ")
  end
end
