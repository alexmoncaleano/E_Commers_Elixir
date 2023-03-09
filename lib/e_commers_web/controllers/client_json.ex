defmodule ECommersWeb.ClientJSON do
  alias ECommers.Clients.Client

  @doc """
  Renders a list of clients.
  """
  def index(%{clients: clients}) do
    %{data: for(client <- clients, do: data(client))}
  end

  @doc """
  Renders a single client.
  """
  def show(%{client: client}) do
    %{data: data(client)}
  end

  # def show(%{client: client}) do
  #  client = Repo.get!(Client, client.id) |> Repo.preload([:invoices, invoices: [:products]])
  #  %{data: data(client)}
  # end

  defp data(%Client{} = client) do
    %{
      id: client.id,
      id_number: client.id_number,
      first_name: client.first_name,
      last_name: client.last_name,
      phone: client.phone,
      email: client.email,
      address: client.address,
      doc_type: client.doc_type,
    }
  end
end
