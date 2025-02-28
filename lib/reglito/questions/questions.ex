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

  def get_by_key(key) do
    Enum.find(all(), fn question -> question.key == key end)
  end
end
