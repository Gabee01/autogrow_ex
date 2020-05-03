defmodule AutogrowFirmware.Actors do
  alias Circuits.GPIO

  @actors ~w(lamp fan pump)a
  @actions ~w(on off)a

  def switch(actor, action) do
    with true <- Enum.any?(@actors, fn x -> x == actor end),
         true <- Enum.any?(@actions, fn x -> x == action end) do
      actor_gpio = get_gpio(actor)
      {:ok, actor_io} = GPIO.open(actor_gpio, :output)

      case action do
        :on -> GPIO.write(actor_io, 0)
        :off -> GPIO.write(actor_io, 1)
      end
    else
      reason -> {:error, reason}
    end
  end

  defp get_gpio(:lamp), do: 13
  defp get_gpio(:fan), do: 19
  # defp get_gpio(:pump), do: 1x
end
