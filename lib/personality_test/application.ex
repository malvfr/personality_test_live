defmodule PersonalityTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PersonalityTestWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PersonalityTest.PubSub},
      # Start the Endpoint (http/https)
      PersonalityTestWeb.Endpoint,
      # Start a worker by calling: PersonalityTest.Worker.start_link(arg)
      # {PersonalityTest.Worker, arg},
      {PersonalityTest.Questions.InMemoryDb, %{}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PersonalityTest.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PersonalityTestWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
