defmodule Reglito.InternalRegulations.InternalRegulation do
  use Ecto.Schema

  import Ecto.Changeset

  alias Reglito.Chapters.Chapter

  schema "internal_regulations" do
    field :cooperative_name, :string
    field :registration_number, :string

    has_many :chapters, Chapter

    timestamps(type: :utc_datetime)
  end

  def changeset(chapter, attrs) do
    # TODO: cast chapters

    chapter
    |> cast(attrs, [])
  end
end
