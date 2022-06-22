defmodule JwtReact.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      JwtReact.Repo,
      # Start the Telemetry supervisor
      JwtReactWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: JwtReact.PubSub},
      # Start the Endpoint (http/https)
      JwtReactWeb.Endpoint
      # Start a worker by calling: JwtReact.Worker.start_link(arg)
      # {JwtReact.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JwtReact.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JwtReactWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
