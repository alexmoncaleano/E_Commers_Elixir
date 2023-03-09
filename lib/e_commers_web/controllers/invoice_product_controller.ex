defmodule ECommersWeb.InvoiceProductController do
  use ECommersWeb, :controller

  alias ECommers.InvoiceProducts
  alias ECommers.InvoiceProducts.InvoiceProduct

  action_fallback ECommersWeb.FallbackController

  def index(conn, _params) do
    invoice_products = InvoiceProducts.list_invoice_products()
    render(conn, :index, invoice_products: invoice_products)
  end

  def create(conn, %{"invoice_product" => invoice_product_params}) do
    with {:ok, %InvoiceProduct{} = invoice_product} <- InvoiceProducts.create_invoice_product(invoice_product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/invoice_products/#{invoice_product}")
      |> render(:show, invoice_product: invoice_product)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_product = InvoiceProducts.get_invoice_product!(id)
    render(conn, :show, invoice_product: invoice_product)
  end

  def update(conn, %{"id" => id, "invoice_product" => invoice_product_params}) do
    invoice_product = InvoiceProducts.get_invoice_product!(id)

    with {:ok, %InvoiceProduct{} = invoice_product} <- InvoiceProducts.update_invoice_product(invoice_product, invoice_product_params) do
      render(conn, :show, invoice_product: invoice_product)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_product = InvoiceProducts.get_invoice_product!(id)

    with {:ok, %InvoiceProduct{}} <- InvoiceProducts.delete_invoice_product(invoice_product) do
      send_resp(conn, :no_content, "")
    end
  end
end
