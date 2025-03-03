defmodule Reglito.Template do
  alias Reglito.Questions

  def fill(key, answer, cooperative) do
    question = Questions.get_by_key(Questions.all_flatten_questions(), key)

    template =
      question.result_template
      |> String.replace("{COOPERATIVE}", cooperative.name)

    type = question.answer_type

    case type do
      :multiple ->
        String.replace(template, "{OPTIONS}", Enum.join(Enum.reverse(answer), ", "))

      :text ->
        String.replace(template, "{OPTIONS}", answer)

      :exclusive ->
        if answer == "SI" do
          String.replace(template, "{OPTIONS}", answer)
        else
          ""
        end
    end
  end
end
