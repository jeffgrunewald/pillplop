defmodule Pillplop.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :pharmacy_id, references(:pharmacies)
      add :latitude, :string
      add :longitude, :string

      timestamps()
    end

  end
end
