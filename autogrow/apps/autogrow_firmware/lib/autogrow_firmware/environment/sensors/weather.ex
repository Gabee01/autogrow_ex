defmodule AutogrowFirmware.Environment.Weather do
  use GenServer
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(%{pin: pin, version: version, update_interval: update_interval}) do
    DHT.start_polling(pin, version, update_interval)

    :telemetry.attach(
      "weather-attached",
      [:dht, :read],
      &__MODULE__.updated_event/4,
      nil
    )

    {:ok, %{a: nil, b: nil, c: nil, d: nil}}
  end

  @impl true
  def init(_), do: {:error, "DHT is not configured.
  Do you have the following configuration in your config/MIX_ENV.exs? :

  config :autogrow_firmware,
  dht: %{
    pin: you_dht_pin, # integer
    version: your_dht_version, # for supported versions see the DHT lib hexdocs
    update_interval: 15 # seconds between updates
  }"}

  def updated_event(a, b, c, d) do
    latest_weather = %{a: a, b: b, c: c, d: d}
    Logger.info("Latest weather: #{inspect(latest_weather)}")
    {:ok, latest_weather}
  end

  # def take() do
  #   %{pin: pin, version: version} = @dht_config
  #   DHT.read(pin, version)
  # end
end
