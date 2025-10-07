defmodule AppRetoElixir.Application do
  use Application

  def start(_type, _args) do
    :ets.new(:users_by_email, [
      :named_table,
      :set,
      :public,
      read_concurrency: true,
      write_concurrency: true
    ])

    :ets.new(:sessions, [
      :named_table,
      :set,
      :public,
      read_concurrency: true,
      write_concurrency: true
    ])

    children = [
      {Plug.Cowboy,
       scheme: :http,
       plug: AppRetoElixir.Infrastructure.EntryPoints.Router,
       options: [port: 8080]}
    ]

    opts = [strategy: :one_for_one, name: AppRetoElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
