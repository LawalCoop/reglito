defmodule Reglito.Sections.Section do
  use Ecto.Schema

  import Ecto.Changeset

  alias Reglito.Chapters.Chapter
  alias Reglito.Options.Option

  schema "sections" do
    field :name, :string

    belongs_to :chapter, Chapter
    has_many :options, Option

    timestamps(type: :utc_datetime)
  end

  def changeset(chapter, attrs) do
    # TODO: cast options

    chapter
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
