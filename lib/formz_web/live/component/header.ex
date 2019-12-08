defmodule FormzWeb.Live.Component.Header do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~L"""
      <h1><%= @title %></h1>
    """
  end

  def mount(_assigns, socket) do
    {:ok, socket}
  end

  def update(%{title: title}, socket) do
    {:ok, assign(socket, title: title)}
  end
end
