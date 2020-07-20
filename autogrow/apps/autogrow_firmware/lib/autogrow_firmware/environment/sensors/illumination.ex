defmodule AutogrowFirmware.Environment.Illumination do
  @i2c_driver Application.get_env(:autogrow_framework, :i2c_driver)

  @luminosity_configurations %{
    # Default device I2C address
    device: <<0x23>>,
    # No active state
    power_down: <<0x00>>,
    # Power on
    power_on: <<0x01>>,
    # Reset data register value
    reset: <<0x07>>,

    # Start measurement at 4lx resolution. Time typically 16ms.
    continuous_low_res_mode: <<0x13>>,
    # Start measurement at 1lx resolution. Time typically 120ms
    # Device is automatically set to Power Down after measurement.
    one_time_low_res_mode: <<0x23>>,

    # Start measurement at 1lx resolution. Time typically 120ms
    continuous_high_res_mode_1: <<0x10>>,
    # Start measurement at 0.5lx resolution. Time typically 120ms
    continuous_high_res_mode_2: <<0x11>>,
    # Start measurement at 1lx resolution. Time typically 120ms
    # Device is automatically set to Power Down after measurement.
    one_time_high_res_mode_1: <<0x20>>,
    # Start measurement at 0.5lx resolution. Time typically 120ms
    # Device is automatically set to Power Down after measurement.
    one_time_high_res_mode_2: <<0x21>>
  }

  # defp luminosity_gpio(), do: 35
  # defp ht_gpio(), do: 18

  # defp configure(:luminosity, configuration) do
  #   with true <- configuration in Map.keys(@luminosity_configurations) do
  #     config_value = Map.get(@luminosity_configurations, configuration)
  #     write(Luminosity, config_value)
  #   end
  # end

  # defp write(name, value) do
  #   GenServer.call(name, {:write, value})
  # end

  # defp read(name, bytes) do
  #   GenServer.call(name, {:read, bytes})
  # end

  # def take() do
  #   with read_value <- read(Luminosity, 2) do
  #     {:ok, :binary.decode_unsigned(read_value)}
  #   end
  # end
end
