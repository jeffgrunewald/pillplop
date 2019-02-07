defmodule PillplopWeb.Router do
  use PillplopWeb, :router

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

  scope "/", PillplopWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/pharmacies", PharmacyController
  end

  # Other scopes may use custom stacks.
  # scope "/api", PillplopWeb do
  #   pipe_through :api
  # end
end
