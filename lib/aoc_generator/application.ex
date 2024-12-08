defmodule AocGenerator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Application.start(:inets)
    Application.start(:ssl)
    {:ok, _profile_pid} = :inets.start(:httpc, [{:profile, :user}])
    :httpc.set_options([cookies: :verify], :user)

    children = [
      # Starts a worker by calling: AocGenerator.Worker.start_link(arg)
      # {AocGenerator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AocGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
