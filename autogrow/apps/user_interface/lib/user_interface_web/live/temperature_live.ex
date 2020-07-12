defmodule UserInterface.ThemperatureLive do
  # If you generated an app with mix phx.new --live,
  # the line below would be: use MyAppWeb, :live_view
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(_params, %{"current_user_id" => _user_id}, socket) do
    # temperature = Thermostat.get_user_reading(user_id)

    # , assign(socket, :temperature, temperature)}
    {:ok}
  end
end
