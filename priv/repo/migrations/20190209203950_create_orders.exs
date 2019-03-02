defmodule Pillplop.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :patient_id, references(:patients)
      add :prescription_id, references(:prescriptions)
      add :location_id, references(:locations)

      timestamps()
    end

  end
end
