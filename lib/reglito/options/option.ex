defmodule Reglito.Options.Option do
  use Ecto.Schema

  import Ecto.Changeset

  alias Reglito.Sections.Section
  alias Reglito.Templates.Template

  schema "options" do
    field :description, :string
    belongs_to :section, Section
    belongs_to :template, Template

    timestamps(type: :utc_datetime)
  end

  def changeset(chapter, attrs) do
    # TODO: cast sections and template

    chapter
    |> cast(attrs, [:description])
    |> validate_required([:description])
  end
end
