defmodule PillplopWeb.Router do
  use PillplopWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Pillplop.Auth.Pipeline
    plug :set_pharmacy_as_asset
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PillplopWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/pharmacies", PharmacyController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/", PillplopWeb do
    pipe_through [:browser, :browser_auth]
    resources "/pharmacies", PharmacyController, only: [:show, :index, :update]
  end

  def set_pharmacy_as_asset(conn, _) do
    pharmacy = conn
    |> Pillplop.Auth.Guardian.Plug.current_resource
    IO.inspect pharmacy
    assign(conn, :current_pharmacy, pharmacy)
  end
end
