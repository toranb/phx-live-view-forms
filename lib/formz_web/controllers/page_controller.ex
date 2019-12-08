defmodule FormzWeb.PageController do
  use FormzWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
