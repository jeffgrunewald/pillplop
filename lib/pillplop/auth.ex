defmodule Pillplop.Auth do
  use PillplopWeb, :controller
  alias Pillplop.Repo

  def auth_by_name_password(name, password) do
    Pillplop.Pharmacy
    |> Repo.get_by(name: name)
    |> check_password(password)

  end

  defp check_password(nil, _password), do: {:error, :unauthorized}
  defp check_password(pharmacy, password) do
    case Comeonin.Bcrypt.check_pass(pharmacy, password) do
      {:ok, _pharmacy} = result -> result
      {:error, _message} -> {:error, :unauthorized}
    end
  end
end
