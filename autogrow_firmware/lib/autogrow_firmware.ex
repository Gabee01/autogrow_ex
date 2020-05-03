defmodule AutogrowFirmware do
  @moduledoc """
  Documentation for AutogrowFirmware.
  """

  alias AutogrowFirmware.Actors
  alias AutogrowFirmware.Sensors

  def switch(actor, action) do
    Actors.switch(actor, action)
  end

  def monitor(measure) do
    Sensors.take(measure)
  end
end
