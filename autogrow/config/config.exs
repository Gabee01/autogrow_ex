# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
# Server Configuration
use Mix.Config

# Configures the endpoint
config :autogrow_server, AutogrowServerWeb.Endpoint,
  http: [port: 80],
  url: [host: "localhost", port: 80],
  secret_key_base: "9ITPa/5VNZ8zvAfNsT8bHHX+8s/ZK4j/L/C9QsO0RlS//Hd3tZaxEfGy1VlT6BGe",
  render_errors: [view: AutogrowServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: AutogrowServer.PubSub,
  live_view: [signing_salt: "037tr3tR"]

config :logger, :console, format: "[$level] $message\n", metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Firmware configuration
config :autogrow_firmware, target: Mix.target()

config :autogrow_firmware,
  dht: %{
    pin: 18,
    version: :dht11,
    # seconds
    update_interval: 15
  }

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1588486004"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [:console]

# We need to override nerves configuration to enable OneWire
config :nerves, :firmware, fwup_conf: "config/rpi/fwup.conf"

if Mix.target() != :host do
  import_config "target.exs"
end
