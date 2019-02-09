defmodule Pillplop.Auth.Guardian do
  use Guardian, otp_app: :pillplop

  alias Pillplop.Repo
  alias Pillplop.Pharmacy

  def subject_for_token(%Pharmacy{} = pharmacy, _claims) do
    {:ok, to_string(pharmacy.id)}
  end

  def resource_from_claims(claims) do
    case claims["sub"] |> get_user() do
      %Pharmacy{} = pharmacy -> {:ok, pharmacy}
      nil -> {:error, :pharmacy_not_found}
    end
  end

  defp get_user(id) do
    Repo.get(Pharmacy, id)
  end
end
