defmodule PillplopWeb.PageController do
  use PillplopWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
