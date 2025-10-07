defmodule AppRetoElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :app_reto_elixir,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        "ca.release": :test,
        "ca.sobelow.sonar": :test,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.xml": :test,
        credo: :test,
        release: :prod,
        sobelow: :test
      ],
      releases: [
        app_reto_elixir: [
          include_executables_for: [:unix],
          steps: [:assemble, :tar]
        ]
      ],
      metrics: false
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {AppRetoElixir.Application, [Mix.env()]}
    ]
  end

  defp deps do
    [
      {:ex_unit_sonarqube, "~> 0.1", only: :test},
      {:credo_sonarqube, "~> 0.1", only: :test},
      {:junit_formatter, "~> 3.4", only: :test},
      {:sobelow, "~> 0.14", only: :test},
      {:castore, "~> 1.0"},
      {:plug_cowboy, "~> 2.7"},
      {:jason, "~> 1.4"},
      {:plug_checkup, "~> 0.6"},
      {:poison, "~> 6.0"},
      {:cors_plug, "~> 3.0"},
      {:timex, "~> 3.7"},
      {:elixir_uuid, "~> 1.2"},
      {:mock, "~> 0.3", only: :test},
      {:excoveralls, "~> 0.18", only: :test},
      {:elixir_structure_manager, ">= 0.0.0", only: [:dev, :test]}
    ]
  end
end
