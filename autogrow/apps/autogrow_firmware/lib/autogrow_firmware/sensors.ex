defmodule AutogrowFirmware.Sensors do
  @moduledoc """
  This takes the temperature, humidity (dht) and luminosity values, and offers this information as an environment status
  """
  alias AutogrowFirmware.Sensors.{Luminosity, Dht}
  @measures ~w(luminosity humidity temperature)a

  defp take(sensor) do
    case sensor do
      :ht -> Dht.take()
      :luminosity -> Luminosity.take()
    end
  end

  @doc """
  This returns an %{:ok, environment} tuple, where the environment contain information from the available sensors
  Ex:
    iex> AutogrowFirmware.Sensors.environment()

  """
  def environment() do
    with {:ok, humidity, temperature} <- Dht.take(:ht),
         {:ok, luminosity} <- take(:luminosity) do
      {:ok, %{humidity: humidity, temperature: temperature, luminosity: luminosity}}
    else
      reason -> reason
    end
  end
end
