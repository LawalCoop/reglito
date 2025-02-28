defmodule Reglito.AnswerForm do
  def build(questions, form \\ %{})

  def build([%{key: key, nested_questions: nil} | tail], form) do
    new_form = Map.put(form, key, nil)
    build(tail, new_form)
  end

  def build(
        [%{key: key, nested_questions: nested_questions} | tail],
        form
      ) do
    new_form = Map.put(form, key, nil)
    build(tail ++ nested_questions, new_form)
  end

  def build([], form) do
    form
  end
end
