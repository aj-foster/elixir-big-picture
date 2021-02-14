defmodule Dots.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DotsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Dots.PubSub},
      # Start the Endpoint (http/https)
      DotsWeb.Endpoint,
      # Supervisor for dot actors
      {DynamicSupervisor, strategy: :one_for_one, name: Dots.DotSupervisor, max_restarts: 1_000},
      # Canvas manager
      Dots.Canvas
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Dots.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DotsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
