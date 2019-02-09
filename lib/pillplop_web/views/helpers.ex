defmodule PillplopWeb.ViewHelper do
  alias Pillplop.Auth.Guardian

  def current_pharmacy(conn), do: Guardian.Plug.current_resource(conn)
  def logged_in?(conn), do: Guardian.Plug.authenticated?(conn)
end
