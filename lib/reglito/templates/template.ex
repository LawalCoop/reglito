defmodule Reglito.Templates.Template do
  use Ecto.Schema

  import Ecto.Changeset

  alias Reglito.Options.Option

  schema "templates" do
    field :text, :string
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
