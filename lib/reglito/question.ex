defmodule Reglito.Question do
  alias Reglito.Chapters

  def fetch_question(questions, field) do
    Enum.find(questions, fn question -> question["field_name"] == field end)
  end

  def fetch_question_keys(questions) do
    Enum.map(questions, fn question -> question["field_name"] end)
  end

  def fetch_question_type(field) do
    all_questions_by_key()[field]["answer_type"]
  end

  def fetch_nested_questions(questions, field) do
    fetch_question(questions, field)["nested_questions"]
  end

  def all_questions_by_key do
    Chapters.sections()
    |> flat_questions
  end

  def flat_questions(questions, map \\ %{})

  def flat_questions(
        [%{"field_name" => field_name, "nested_questions" => nil} = question | tail],
        map
      ) do
    new_map = Map.put(map, field_name, Map.delete(question, "nested_questions"))
    flat_questions(tail, new_map)
  end

  def flat_questions(
        [%{"field_name" => field_name, "nested_questions" => nested_questions} = question | tail],
        map
      ) do
    new_map = Map.put(map, field_name, Map.delete(question, "nested_questions"))
    flat_questions(tail ++ nested_questions, new_map)
  end

  def flat_questions([], map), do: map
end
