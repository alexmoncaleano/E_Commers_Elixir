defmodule ECommersWeb.InvoiceController do
  use ECommersWeb, :controller

  alias ECommers.Invoices
  alias ECommers.Invoices.Invoice

  action_fallback ECommersWeb.FallbackController

  def index(conn, _params) do
    invoices = Invoices.list_invoices()
    render(conn, :index, invoices: invoices)
  end

  def create(conn, %{"invoice" => invoice_params}) do
    with {:ok, %Invoice{} = invoice} <- Invoices.create_invoice(invoice_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/invoices/#{invoice}")
      |> render(:show, invoice: invoice)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    invoice = Invoices.get_invoice!(id) 
    #invoice = ECommers.Invoices.get_invoice!(id) |> Ecto.assoc(:client) |> Repo.preload([:products])
    render(conn, :show, invoice: invoice)
  end

  def update(conn, %{"id" => id, "invoice" => invoice_params}) do
    invoice = Invoices.get_invoice!(id)

    with {:ok, %Invoice{} = invoice} <- Invoices.update_invoice(invoice, invoice_params) do
      render(conn, :show, invoice: invoice)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice = Invoices.get_invoice!(id)

    with {:ok, %Invoice{}} <- Invoices.delete_invoice(invoice) do
      send_resp(conn, :no_content, "")
    end
  end
end
