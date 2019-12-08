defmodule FormzWeb.PageController do
  use FormzWeb, :controller

  alias Phoenix.LiveView

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _params) do
    session_name = Ecto.UUID.generate()

    case Formz.SessionSupervisor.start_session(session_name) do
      {:ok, _pid} ->
        redirect(conn, to: Routes.page_path(conn, :signup, session_name))

      {:error, {:already_started, _pid}} ->
        redirect(conn, to: Routes.page_path(conn, :signup, session_name))

      {:error, _error} ->
        render(conn, "index.html")
    end
  end

  def signup(conn, %{"id" => session_name}) do
    case Formz.Session.session_pid(session_name) do
      pid when is_pid(pid) ->
        render_live_view(conn, session_name)

      nil ->
        redirect_user(conn)
    end
  end

  @doc false
  def redirect_user(conn) do
    conn
    |> put_flash(:error, "session not found")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  @doc false
  def render_live_view(conn, session_name) do
    LiveView.Controller.live_render(conn, FormzWeb.Live.SignupLive,
      session: %{
        session_name: session_name,
        error: nil
      }
    )
  end
end
