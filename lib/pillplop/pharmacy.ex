defmodule Pillplop.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pharmacies" do
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> put_password_hash()
  end

  def registration_changeset(pharmacy, attrs) do
    pharmacy
    |> changeset(attrs)
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash,
          Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
