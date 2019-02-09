defmodule PillplopWeb.Token do
  use PillplopWeb, :controller
  def unauthenticated(conn, _params) do
    conn
    |> put_flash(:info, "You must be signed in to access this page")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  def unauthorized(conn, _params) do
    conn
    |> put_flash(:error, "You must be signed in to access this page")
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
