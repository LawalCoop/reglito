defmodule Reglito.Chapters.Chapter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chapters" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chapter, attrs) do
    chapter
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
