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
end
