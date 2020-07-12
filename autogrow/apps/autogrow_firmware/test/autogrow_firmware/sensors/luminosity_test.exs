defmodule AutogrowFirmware.Sensors.LuminosityTest do
  use ExUnit.Case
  doctest AutogrowFirmware

  alias AutogrowFirmware.Sensors.Luminosity

  describe "take/0" do
    test "should return i2c luminosity value" do
      Luminosity.take() |> IO.inspect()
    end
  end
end
