defmodule Reglito.Template do
  alias Reglito.Question
  alias Reglito.Chapters

  def by_question() do
    Chapters.sections()
    |> extract_template()
  end

  def extract_template(questions, templates \\ %{})

  def extract_template(
        [
          %{
            "field_name" => field_name,
            "nested_questions" => nil,
            "result_template" => result_template
          }
          | tail
        ],
        templates
      ) do
    new_templates = Map.put(templates, field_name, result_template)
    extract_template(tail, new_templates)
  end

  def extract_template(
        [
          %{
            "field_name" => field_name,
            "nested_questions" => nested_questions,
            "result_template" => result_template
          }
          | tail
        ],
        templates
      ) do
    new_templates = Map.put(templates, field_name, result_template)
    extract_template(tail ++ nested_questions, new_templates)
  end

  def extract_template([], templates) do
    templates
  end

  def fill(key, answer) do
    question =
      Question.all_questions_by_key()
      |> Map.get(key, %{})

    template =
      question
      |> Map.fetch!("result_template")

    type =
      question
      |> Map.fetch!("answer_type")

    case type do
      "multiple" -> String.replace(template, "{OPTIONS}", Enum.join(Enum.reverse(answer), ", "))
      "text" -> String.replace(template, "{OPTIONS}", answer)
    end
  end
end
