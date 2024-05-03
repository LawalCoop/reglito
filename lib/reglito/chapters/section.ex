defmodule Reglito.Chapters.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias Reglito.Chapters.Section

  embedded_schema do 
    field :output, :string
    field :options, {:array, :string}
    field :description, :string
  end

  @doc false
  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:description, :options, :output])
    |> validate_required([:description, :options, :output])
  end
end
