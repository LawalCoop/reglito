defmodule Reglito.Chapters do
  def read_chapters_description!() do
    case File.read("lib/reglito/chapters_description.json") do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, json_data} ->
            json_data

          {:error, error} ->
            raise "Error al parsear el JSON: #{error}"
        end

      {:error, reason} ->
        raise "Error al leer el archivo: #{reason}"
    end
  end

  def read_chapters_data!() do
    case File.read("lib/reglito/chapters_data.json") do
      {:ok, content} ->
        case Jason.decode(content) do
          {:ok, json_data} ->
            json_data

          {:error, error} ->
            raise "Error al parsear el JSON: #{error}"
        end

      {:error, reason} ->
        raise "Error al leer el archivo: #{reason}"
    end
  end
end
