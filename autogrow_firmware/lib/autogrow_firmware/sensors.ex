defmodule AutogrowFirmware.Sensors do
  alias Circuits.I2C

  @measures ~w(luminosity humidity temperature)a

  @i2c_luminosity %{
    # Default device I2C address
    device: 0x23,
    # No active state
    power_down: 0x00,
    # Power on
    power_on: 0x01,
    # Reset data register value
    reset: 0x07,

    # Start measurement at 4lx resolution. Time typically 16ms.
    continuous_low_res_mode: 0x13,
    # Start measurement at 1lx resolution. Time typically 120ms
    # Device is automatically set to Power Down after measurement.
    one_time_low_res_mode: 0x23,

    # Start measurement at 1lx resolution. Time typically 120ms
    continuous_high_res_mode_1: 0x10,
    # Start measurement at 0.5lx resolution. Time typically 120ms
    continuous_high_res_mode_2: 0x11,
    # Start measurement at 1lx resolution. Time typically 120ms
    # Device is automatically set to Power Down after measurement.
    one_time_high_res_mode_1: 0x20,
    # Start measurement at 0.5lx resolution. Time typically 120ms
    # Device is automatically set to Power Down after measurement.
    one_time_high_res_mode_2: 0x21
  }

  def take(measure = :luminosity) do
    luminosity_gpio = 35

    {:ok, light_sensor} = I2C.open("i2c-1")

    I2C.write(light_sensor, luminosity_gpio, <<0x10>>, [])

    {:ok, read_value} = I2C.read(light_sensor, luminosity_gpio, 2, [])
    :binary.decode_unsigned(read_value)
  end

  def take(measure = :ht) do
    # System.get_env(:config, :sensors, :ht)
    ht_gpio = 18

    {:ok, humidity, temperature} = NervesDHT.read(:dht11, ht_gpio)
    {:ok, [humidity, temperature]}
  end
end
