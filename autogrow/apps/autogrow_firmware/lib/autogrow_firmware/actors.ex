defmodule AutogrowFirmware.Actors do
  # alias Circuits.GPIO
  # alias ElixirALE.GPIO

  # @actors ~w(lamp fan pump)a
  # @actions ~w(on off)a

  # def switch(actor, action) do
  #   with true <- Enum.any?(@actors, fn x -> x == actor end),
  #        true <- Enum.any?(@actions, fn x -> x == action end) do
  #     actor_name = get_actor(actor)

  #     case action do
  #       :on -> write(actor_name, 0)
  #       :off -> write(actor_name, 1)
  #     end
  #   else
  #     reason -> {:error, reason}
  #   end
  # end

  # defp write(actor_name, value) do
  #   GenServer.call(actor_name, {:write, value})
  # end

  # defp get_actor(:lamp), do: Lamp
  # defp get_actor(:fan), do: Fan
  # # defp get_gpio(:pump), do: 1x
end
