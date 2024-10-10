defmodule ReglitoWeb.Start.Helpers do
  def current_section(sections, index) do
    Enum.at(sections, index)
  end

  def chapter(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("chapter")
  end

  def question(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("question")
  end

  def options(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("options")
  end

  def aswer_type(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("aswer_type")
  end

  def related_question(sections, index) do
    current_section(sections, index)
    |> Map.get("related_question")
  end
end
