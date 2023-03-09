defmodule ECommers.InvoicesTest do
  use ECommers.DataCase

  alias ECommers.Invoices

  describe "invoices" do
    alias ECommers.Invoices.Invoice

    import ECommers.InvoicesFixtures

    @invalid_attrs %{items: nil, price: nil, status: nil, tax: nil}

    test "list_invoices/0 returns all invoices" do
      invoice = invoice_fixture()
      assert Invoices.list_invoices() == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = invoice_fixture()
      assert Invoices.get_invoice!(invoice.id) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      valid_attrs = %{items: [], price: 120.5, status: "some status", tax: 120.5}

      assert {:ok, %Invoice{} = invoice} = Invoices.create_invoice(valid_attrs)
      assert invoice.items == []
      assert invoice.price == 120.5
      assert invoice.status == "some status"
      assert invoice.tax == 120.5
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Invoices.create_invoice(@invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = invoice_fixture()
      update_attrs = %{items: [], price: 456.7, status: "some updated status", tax: 456.7}

      assert {:ok, %Invoice{} = invoice} = Invoices.update_invoice(invoice, update_attrs)
      assert invoice.items == []
      assert invoice.price == 456.7
      assert invoice.status == "some updated status"
      assert invoice.tax == 456.7
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Invoices.update_invoice(invoice, @invalid_attrs)
      assert invoice == Invoices.get_invoice!(invoice.id)
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{}} = Invoices.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Invoices.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = invoice_fixture()
      assert %Ecto.Changeset{} = Invoices.change_invoice(invoice)
    end
  end
end
