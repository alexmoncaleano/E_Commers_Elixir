defmodule ECommersWeb.InvoiceProductControllerTest do
  use ECommersWeb.ConnCase

  import ECommers.InvoiceProductsFixtures

  alias ECommers.InvoiceProducts.InvoiceProduct

  @create_attrs %{
    quantity: 42
  }
  @update_attrs %{
    quantity: 43
  }
  @invalid_attrs %{quantity: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all invoice_products", %{conn: conn} do
      conn = get(conn, ~p"/api/invoice_products")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create invoice_product" do
    test "renders invoice_product when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/invoice_products", invoice_product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/invoice_products/#{id}")

      assert %{
               "id" => ^id,
               "quantity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/invoice_products", invoice_product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update invoice_product" do
    setup [:create_invoice_product]

    test "renders invoice_product when data is valid", %{conn: conn, invoice_product: %InvoiceProduct{id: id} = invoice_product} do
      conn = put(conn, ~p"/api/invoice_products/#{invoice_product}", invoice_product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/invoice_products/#{id}")

      assert %{
               "id" => ^id,
               "quantity" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, invoice_product: invoice_product} do
      conn = put(conn, ~p"/api/invoice_products/#{invoice_product}", invoice_product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete invoice_product" do
    setup [:create_invoice_product]

    test "deletes chosen invoice_product", %{conn: conn, invoice_product: invoice_product} do
      conn = delete(conn, ~p"/api/invoice_products/#{invoice_product}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/invoice_products/#{invoice_product}")
      end
    end
  end

  defp create_invoice_product(_) do
    invoice_product = invoice_product_fixture()
    %{invoice_product: invoice_product}
  end
end
