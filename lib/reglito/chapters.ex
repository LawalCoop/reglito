defmodule Reglito.Chapters do
  @chapters_description_file "lib/reglito/json/chapters_description.json"
  @chapters_data_file "lib/reglito/json/chapters_data.json"

  @chapters_description Jason.decode!(File.read!(@chapters_description_file))
  @chapters_data Jason.decode!(File.read!(@chapters_data_file))

  def read_chapters_description() do
    @chapters_description
  end

  def read_chapters_data() do
    @chapters_data
  end

  def chapter_name_by_code() do
    for %{"code" => code, "name" => name} <- read_chapters_description(),
        into: %{},
        do: {code, name}
  end

  def selected_chapters_data(selected_chapers_keys) do
    read_chapters_data()
    |> Enum.filter(fn {key, _value} -> key in selected_chapers_keys end)
    |> Enum.into(%{})
  end

  def all_sections(chapters) do
    Enum.flat_map(chapters, fn {chapter_key, %{"sections" => sections}} ->
      Enum.map(sections, fn section ->
        Map.put(section, "chapter", chapter_key)
      end)
    end)
  end
end
