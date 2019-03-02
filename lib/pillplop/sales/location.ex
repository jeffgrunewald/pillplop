defmodule Pillplop.Sales.Location do
  use Ecto.Schema
  import Ecto.Changeset


  schema "locations" do
    field :latitude, :string
    field :longitude, :string
    field :pharmacy_id, :integer
    has_many :orders, Pillplop.Sales.Order

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:pharmacy_id, :latitude, :longitude])
    |> validate_required([:pharmacy_id, :latitude, :longitude])
  end
end
