defmodule Reglito.Repo.Migrations.CreateChapters do
  use Ecto.Migration

  def change do
    create table(:chapters) do
      add :name, :string

      add :internal_regulation, references(:internal_regulations)
      timestamps(type: :utc_datetime)
    end
  end
end
