defmodule AutogrowFirmware.Environment do
  use Supervisor
  require Logger

  @moduledoc """

  This takes the temperature, humidity (Weather) and luminosity values, and offers this information as an environment status
  """
  alias AutogrowFirmware.Environment.{Illumination, Weather}
  @measures ~w(luminosity humidity temperature)a

  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @dht_config Application.get_env(:autogrow_firmware, :dht)

  @impl true
  def init(_init_arg) do
    children = [
      {Weather, [@dht_config]}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  # def handle_call(:update_ht, %{humidity: humidity, temperature: temperature}, state) do
  #   state = state |> Map.put(humidity: humidity) |> Map.put(temperature: temperature)

  #   {:reply, :ok, state}
  # end

  # def handle_call(:get, _from, state) do
  #   {:reply, state, state}
  # end

  # defp take(sensor) do
  #   case sensor do
  #     :ht ->
  #       {:ok, %{humidity: humidity, temperature: temperature}} = Weather.take()
  #       {:ok, humidity, temperature}

  #     :humidity ->
  #       {:ok, %{humidity: humidity}} = Weather.take()
  #       {:ok, humidity}

  #     :temperature ->
  #       {:ok, %{temperature: temperature}} = Weather.take()
  #       {:ok, temperature}

  #     :luminosity ->
  #       Illumination.take()
  #   end
  # end

  # @doc """
  # This returns an %{:ok, environment} tuple, where the environment contain information from the available sensors
  # Ex:
  #   iex> AutogrowFirmware.Environment.snapshot()

  # """
  # def snapshot() do
  #   with {:ok, humidity} <- take(:humidity),
  #        {:ok, temperature} <- take(:temperature) do
  #     # {:ok, luminosity} <- take(:luminosity)
  #     {:ok, %{humidity: humidity, temperature: temperature}}
  #   else
  #     reason -> reason
  #   end
  # end

  # def listen({:ok, p, s, h, t}) do
  #   IO.puts("Listen event on Environment0 .")
  #   IO.puts("Pin: #{p}, Sensor: #{s}\n")
  #   IO.puts("Temperature: #{t}, Humidity: #{h})\n")
  # end
end
