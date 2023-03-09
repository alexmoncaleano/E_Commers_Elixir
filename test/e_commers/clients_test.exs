defmodule ECommers.ClientsTest do
  use ECommers.DataCase

  alias ECommers.Clients

  describe "clients" do
    alias ECommers.Clients.Client

    import ECommers.ClientsFixtures

    @invalid_attrs %{address: nil, doc_type: nil, email: nil, first_name: nil, id_number: nil, last_name: nil, phone: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Clients.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Clients.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{address: "some address", doc_type: "some doc_type", email: "some email", first_name: "some first_name", id_number: "some id_number", last_name: "some last_name", phone: "some phone"}

      assert {:ok, %Client{} = client} = Clients.create_client(valid_attrs)
      assert client.address == "some address"
      assert client.doc_type == "some doc_type"
      assert client.email == "some email"
      assert client.first_name == "some first_name"
      assert client.id_number == "some id_number"
      assert client.last_name == "some last_name"
      assert client.phone == "some phone"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{address: "some updated address", doc_type: "some updated doc_type", email: "some updated email", first_name: "some updated first_name", id_number: "some updated id_number", last_name: "some updated last_name", phone: "some updated phone"}

      assert {:ok, %Client{} = client} = Clients.update_client(client, update_attrs)
      assert client.address == "some updated address"
      assert client.doc_type == "some updated doc_type"
      assert client.email == "some updated email"
      assert client.first_name == "some updated first_name"
      assert client.id_number == "some updated id_number"
      assert client.last_name == "some updated last_name"
      assert client.phone == "some updated phone"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(client, @invalid_attrs)
      assert client == Clients.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Clients.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Clients.change_client(client)
    end
  end
end
