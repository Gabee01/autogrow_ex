defmodule AutogrowFirmware.Sensors.Dht do
  def take() do
    NervesDHT.device_read(:dht)
  end
end
