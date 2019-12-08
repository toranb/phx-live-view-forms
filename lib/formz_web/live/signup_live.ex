defmodule FormzWeb.Live.SignupLive do
  use Phoenix.LiveView

  alias FormzWeb.Live.Component.Header

  def render(assigns) do
    ~L"""
      <%= live_component(@socket, Header, title: "Signup") %>
    """
  end

  def mount(%{session_name: session_name}, socket) do
    state = Formz.Session.session_state(session_name)

    {:ok, set_state(socket, state)}
  end

  @doc false
  def set_state(socket, state) do
    data =
      state
      |> Map.from_struct()

    assign(socket, data)
  end
end
