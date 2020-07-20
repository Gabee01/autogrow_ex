defmodule AutogrowServerWeb.EnvironmentLive do
  use AutogrowServerWeb, :live_view

  @topic "environment"

  def render(assigns) do
    AutogrowService.PageView.render("index.html", assigns)
  end

  def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(_session, socket) do
    AutogrowService.Endpoint.subscribe(@topic)
    {:ok, assign(socket, text: "Ready!", status: "ready")}
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  # @impl true
  # def handle_event("suggest", %{"q" => query}, socket) do
  #   {:noreply, assign(socket, results: search(query), query: query)}
  # end
end
