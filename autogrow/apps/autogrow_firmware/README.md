# AutogrowFirmware

Autogrow is a project for an automated greenhouse. We have actors (lamp, pump, fan) and sensors (luminosity, temperature, humidity)

Sensors:
- Luminosity: https://www.okystar.com/product-item/light-sensor-gy-30-oky3457/
- Temperature and humidity: https://www.filipeflop.com/produto/sensor-de-umidade-e-temperatura-dht11/

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

export those env vars:
`MIX_TARGET=rpi3 #raspberry version`
`WIFI_SSID="" #Wireless ssid`
`WIFI_PSK="" #Wireless password`

To start your Nerves app:
  * `export MIX_TARGET=my_target` for all vars above or prefix every command with
    each var like this, `MIX_TARGET=rpi3 WIFI_SSID="house" WIFI_PSK="1234 mix deps.get`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`
  * (Optional, but awesome) There is a `./build.sh` script wich will build the release and upload it to the target via wireless connection (needs wireless setup first). Just put your rpi ip in the script and create the .env file with the envs above at the same level as the script

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves
  * Didn't read, but related: https://frank.kumro.io/building-a-raspberry-pi-weather-station-with-elixir-nerves-part-1/