defmodule Pillplop.Repo.Migrations.CreatePharmacies do
  use Ecto.Migration

  def change do
    create table(:pharmacies) do
      add :name, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
