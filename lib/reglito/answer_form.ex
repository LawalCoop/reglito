defmodule Reglito.AnswerForm do
  def build(questions, form \\ %{})

  def build([%{"field_name" => field_name, "nested_questions" => nil} | tail], form) do
    new_form = Map.put(form, field_name, nil)
    build(tail, new_form)
  end

  def build(
        [%{"field_name" => field_name, "nested_questions" => nested_questions} | tail],
        form
      ) do
    new_form = Map.put(form, field_name, nil)
    build(tail ++ nested_questions, new_form)
  end

  def build([], form) do
    form
  end
end
