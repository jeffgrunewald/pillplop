defmodule Pillplop.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :pillplop,
                              error_handler: Pillplop.Auth.ErrorHandler,
                              module: Pillplop.Auth.Guardian

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
