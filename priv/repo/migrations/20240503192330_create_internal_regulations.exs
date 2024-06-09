defmodule Reglito.Repo.Migrations.CreateInternalRegulations do
  use Ecto.Migration

  def change do
    create table(:internal_regulations) do
      add :cooperative_name, :string
      add :registration_number, :string

      timestamps(type: :utc_datetime)
    end
  end
end
