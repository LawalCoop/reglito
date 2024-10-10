defmodule ReglitoWeb.Start.Helpers do
  def current_section(sections, index) do
    Enum.at(sections, index)
  end

  def chapter(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("chapter")
  end
end
