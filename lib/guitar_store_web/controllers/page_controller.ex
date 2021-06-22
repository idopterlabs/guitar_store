defmodule GuitarStoreWeb.PageController do
  use GuitarStoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
