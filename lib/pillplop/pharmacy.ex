defmodule Pillplop.Pharmacy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "pharmacies" do
    field :name, :string
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(pharmacy, attrs) do
    pharmacy
    |> cast(attrs, [:name, :password_hash])
    |> validate_required([:name, :password_hash])
  end
end
