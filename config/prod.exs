import Config

config :name_project,
  timezone: "America/Bogota",
  env: :prod,
  http_port: 8080,
  enable_server: true,
  version: "0.0.1",
  custom_metrics_prefix_name: "name_project"

config :logger,
  level: :warning
