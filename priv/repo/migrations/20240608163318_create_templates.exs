defmodule Reglito.Repo.Migrations.CreateTemplates do
  use Ecto.Migration

  def change do
    create table(:templates) do
      add :text, :string

      timestamps(type: :utc_datetime)
    end
  end
end
