defmodule Motivator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MotivatorWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:motivator, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Motivator.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Motivator.Finch},
      # Start a worker by calling: Motivator.Worker.start_link(arg)
      # {Motivator.Worker, arg},
      # Start to serve requests, typically the last entry
      MotivatorWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Motivator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MotivatorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
