defmodule Reglito.Repo.Migrations.CreateSections do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :name, :string
      add :can_select_many, :boolean

      add :chapter_id, references(:chapters)

      timestamps(type: :utc_datetime)
    end
  end
end
