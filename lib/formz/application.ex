defmodule Formz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Formz.Repo,
      FormzWeb.Endpoint,
      {Registry, keys: :unique, name: Formz.Registry},
      Formz.SessionSupervisor
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Formz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FormzWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
