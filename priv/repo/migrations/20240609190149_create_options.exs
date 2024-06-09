defmodule Reglito.Repo.Migrations.CreateOptions do
  use Ecto.Migration

  def change do
    create table(:options) do
      add :description, :string

      add :section_id, references(:sections)
      add :template_id, references(:templates)

      timestamps(type: :utc_datetime)
    end
  end
end
