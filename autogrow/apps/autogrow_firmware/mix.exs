defmodule AutogrowFirmware.MixProject do
  use Mix.Project

  @app :autogrow_firmware
  @version "0.1.0"
  @all_targets [:rpi, :rpi0, :rpi2, :rpi3, :rpi3a, :rpi4, :bbb, :x86_64]

  def project do
    [
      app: @app,
      version: @version,
      elixir: "~> 1.9",
      archives: [nerves_bootstrap: "~> 1.8"],
      start_permanent: Mix.env() == :prod,
      build_embedded: true,
      aliases: [loadconfig: [&bootstrap/1]],
      deps: deps(),
      releases: [{@app, release()}],
      preferred_cli_target: [run: :host, test: :host]
    ]
  end

  # Starting nerves_bootstrap adds the required aliases to Mix.Project.config()
  # Aliases are only added if MIX_TARGET is set.
  def bootstrap(args) do
    Application.start(:nerves_bootstrap)
    Mix.Task.run("loadconfig", args)
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {AutogrowFirmware.Application, []},
      extra_applications: [:logger, :runtime_tools, :autogrow_server]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Phoenix server dependencies
      {:autogrow_server, in_umbrella: true},
      {:phoenix_pubsub, "~> 2.0"},
      {:nerves_networking, github: "nerves-project/nerves_networking"},

      # Dependencies for all targets
      {:nerves, "~> 1.6.0", runtime: false},
      {:shoehorn, "~> 0.6"},
      {:ring_logger, "~> 0.6"},
      {:toolshed, "~> 0.2"},
      {:telemetry, "~> 0.4.0"},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.6", targets: @all_targets},
      {:nerves_pack, "~> 0.2", targets: @all_targets},
      {:vintage_net_wifi, "~> 0.7.0", targets: @all_targets},
      # {:circuits_gpio, "~> 0.4", targets: @all_targets},
      # {:circuits_i2c, "~> 0.1", targets: @all_targets},
      {:dht, "~> 0.1"},
      {:elixir_ale, "~> 1.2"},
      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.11", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.11", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.11", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.11", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.11", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.11", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.6", runtime: false, targets: :bbb},
      {:nerves_system_x86_64, "~> 1.11", runtime: false, targets: :x86_64}
    ]
  end

  def release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble],
      strip_beams: Mix.env() == :prod
    ]
  end
end