defmodule FormzWeb.Router do
  use FormzWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FormzWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/new", PageController, :new
    get "/signup/:id", PageController, :signup
  end

  # Other scopes may use custom stacks.
  # scope "/api", FormzWeb do
  #   pipe_through :api
  # end
end
