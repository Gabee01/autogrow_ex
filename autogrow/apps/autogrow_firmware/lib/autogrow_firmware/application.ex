defmodule AutogrowFirmware.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AutogrowFirmware.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: AutogrowFirmware.Worker.start_link(arg)
        # {AutogrowFirmware.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: AutogrowFirmware.Worker.start_link(arg)
      # {AutogrowFirmware.Worker, arg},
    ]
  end

  def children(_target) do
    lum_i2c_address =
      "i2c-1"
      |> ElixirALE.I2C.detect_devices()
      |> List.first()

    # TODO: read those from env vars
    dht_pin = 18
    lamp_pin = 13
    fan_pin = 19

    [
      # Children for all targets except host
      # Starts a worker by calling: AutogrowFirmware.Worker.start_link(arg)
      # {AutogrowFirmware.Worker, arg},
      %{
        id: Lamp,
        name: Lamp,
        start: {ElixirALE.GPIO, :start_link, [lamp_pin, :output]}
      },
      %{
        id: Fan,
        name: Fan,
        start: {ElixirALE.GPIO, :start_link, [fan_pin, :output]}
      },
      %{
        id: Luminosity,
        name: Luminosity,
        start: {ElixirALE.I2C, :start_link, ["i2c-1", lum_i2c_address]}
      },
      {NervesDHT, [name: :dht, sensor: :dht11, pin: dht_pin]}
    ]
  end

  def target() do
    Application.get_env(:autogrow_firmware, :target)
  end
end
