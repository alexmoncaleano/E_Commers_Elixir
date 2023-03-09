defmodule ECommersWeb.Router do
  use ECommersWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ECommersWeb do
    pipe_through :api


    put "/client/:id", ClientController, :update
    put "/invoice/:id", InvoiceController, :update
    put "/product/:id", ProductController, :update
    put "/invoice_products/:id", InvoiceProductController, :update

    resources "/invoices", InvoiceController, only: [:index, :show, :create, :delete]
    resources "/products", ProductController, only: [:index, :show, :create, :delete]
    resources "/clients", ClientController, only: [:index, :show, :create, :delete]
    resources "/invoice_products", InvoiceProductController, only: [:index, :show, :create, :delete]

  end
end
