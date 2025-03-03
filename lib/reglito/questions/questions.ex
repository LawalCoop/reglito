defmodule Reglito.Questions do
  alias UUIDv7
  alias Reglito.Questions.CooperativeQuestions

  def all do
    CooperativeQuestions.all()
  end

  def all_keys do
    Enum.map(all(), fn question ->
      question.key
    end)
  end

  def all_flatten_questions do
    all()
    |> flat_questions()
  end

  defp flat_questions(to_flat, flatten \\ [])

  defp flat_questions([%{nested_questions: nil} = question | tail], flatten) do
    flat_questions(tail, [question | flatten])
  end

  defp flat_questions([%{nested_questions: nested_questions} = question | tail], flatten) do
    flat_questions(tail ++ nested_questions, [question | flatten])
  end

  defp flat_questions([], flatten) do
    flatten
  end

  def get_by_key(key) do
    Enum.find(all(), fn question -> question.key == key end)
  end

  def get_by_key(questions, key) do
    Enum.find(questions, fn question -> question.key == key end)
  end
end
