defmodule ECommers.InvoiceProductsTest do
  use ECommers.DataCase

  alias ECommers.InvoiceProducts

  describe "invoice_products" do
    alias ECommers.InvoiceProducts.InvoiceProduct

    import ECommers.InvoiceProductsFixtures

    @invalid_attrs %{quantity: nil}

    test "list_invoice_products/0 returns all invoice_products" do
      invoice_product = invoice_product_fixture()
      assert InvoiceProducts.list_invoice_products() == [invoice_product]
    end

    test "get_invoice_product!/1 returns the invoice_product with given id" do
      invoice_product = invoice_product_fixture()
      assert InvoiceProducts.get_invoice_product!(invoice_product.id) == invoice_product
    end

    test "create_invoice_product/1 with valid data creates a invoice_product" do
      valid_attrs = %{quantity: 42}

      assert {:ok, %InvoiceProduct{} = invoice_product} = InvoiceProducts.create_invoice_product(valid_attrs)
      assert invoice_product.quantity == 42
    end

    test "create_invoice_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = InvoiceProducts.create_invoice_product(@invalid_attrs)
    end

    test "update_invoice_product/2 with valid data updates the invoice_product" do
      invoice_product = invoice_product_fixture()
      update_attrs = %{quantity: 43}

      assert {:ok, %InvoiceProduct{} = invoice_product} = InvoiceProducts.update_invoice_product(invoice_product, update_attrs)
      assert invoice_product.quantity == 43
    end

    test "update_invoice_product/2 with invalid data returns error changeset" do
      invoice_product = invoice_product_fixture()
      assert {:error, %Ecto.Changeset{}} = InvoiceProducts.update_invoice_product(invoice_product, @invalid_attrs)
      assert invoice_product == InvoiceProducts.get_invoice_product!(invoice_product.id)
    end

    test "delete_invoice_product/1 deletes the invoice_product" do
      invoice_product = invoice_product_fixture()
      assert {:ok, %InvoiceProduct{}} = InvoiceProducts.delete_invoice_product(invoice_product)
      assert_raise Ecto.NoResultsError, fn -> InvoiceProducts.get_invoice_product!(invoice_product.id) end
    end

    test "change_invoice_product/1 returns a invoice_product changeset" do
      invoice_product = invoice_product_fixture()
      assert %Ecto.Changeset{} = InvoiceProducts.change_invoice_product(invoice_product)
    end
  end
end
