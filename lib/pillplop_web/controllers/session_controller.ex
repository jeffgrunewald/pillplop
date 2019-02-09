defmodule PillplopWeb.SessionController do
  use PillplopWeb, :controller
  alias Pillplop.Auth
  alias Pillplop.Auth.Guardian

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"pharmacy" => %{"name" => name, "password" => password}}) do
    case Auth.auth_by_name_password(name, password) do
      {:ok, pharmacy} ->
#        logged_in_pharmacy = Guardian.Plug.current_resource(conn)
        conn
        |> Guardian.Plug.sign_in(pharmacy)
        |> put_flash(:info, "Logged in")
        |> redirect(to: "/pharmacies")
#       |> redirect(to: Routes.pharmacy_path(conn, :show, logged_in_pharmacy))
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Wrong name/password")
        |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> redirect(to: "/")
  end
end
