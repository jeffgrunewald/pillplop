defmodule Pillplop.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :location_id, :integer
    field :prescription_id, :integer
    belongs_to :patient, Pillplop.Customers.Patient
    # has_one :prescription, Pillplop.Products.Prescription <- invalid association warning

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:patient_id, :prescription_id, :location_id])
    |> validate_required([:patient_id, :prescription_id, :location_id])
  end
end
