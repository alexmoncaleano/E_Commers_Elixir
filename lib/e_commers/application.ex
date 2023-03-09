defmodule ECommers.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ECommersWeb.Telemetry,
      # Start the Ecto repository
      ECommers.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ECommers.PubSub},
      # Start the Endpoint (http/https)
      ECommersWeb.Endpoint
      # Start a worker by calling: ECommers.Worker.start_link(arg)
      # {ECommers.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ECommers.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ECommersWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
