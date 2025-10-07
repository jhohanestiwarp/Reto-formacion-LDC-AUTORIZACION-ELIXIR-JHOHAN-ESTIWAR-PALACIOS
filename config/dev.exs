import Config

config :name_project,
  timezone: "America/Bogota",
  env: :dev,
  http_port: 8083,
  enable_server: true,
  version: "0.0.1",
  custom_metrics_prefix_name: "name_project_local"

config :logger,
  level: :debug
