defmodule Pillplop.Repo do
  use Ecto.Repo,
    otp_app: :pillplop,
    adapter: Ecto.Adapters.Postgres
end
