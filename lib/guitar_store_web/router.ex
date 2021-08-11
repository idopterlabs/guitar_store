defmodule GuitarStoreWeb.Router do
  use GuitarStoreWeb, :router

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

  scope "/", GuitarStoreWeb do
    pipe_through :browser

    get "/", GuitarController, :index
    resources "/guitars", GuitarController
  end
end
