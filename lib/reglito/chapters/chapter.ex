defmodule Reglito.Chapters.Chapter do
  use Ecto.Schema

  import Ecto.Changeset

  alias Reglito.InternalRegulations.InternalRegulation
  alias Reglito.Sections.Section

  schema "chapters" do
    field :name, :string

    belongs_to :internal_regulation, InternalRegulation
    has_many :sections, Section

    timestamps(type: :utc_datetime)
  end

  def changeset(chapter, attrs) do
    # TODO: cast sections

    chapter
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
