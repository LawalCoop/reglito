defmodule Reglito.Template do
  def render(filled_templates, result \\ [])

  def render([{template_filled, [nil]} | tail], result) do
    result = result ++ [template_filled]
    render(tail, result)
  end

  def render([{template_filled, nil} | tail], result) do
    result = result ++ [template_filled]
    render(tail, result)
  end

  def render([{template_filled, nested} | tail], result) do
    result = result ++ [template_filled]
    render(nested ++ tail, result)
  end

  def render([], result) do
    result
  end

  def fill_all(questions, answers, cooperative) do
    Enum.map(questions, fn question ->
      answer = Map.get(answers, question.key)

      nested_filled_templates =
        if not is_nil(question.nested_questions),
          do: fill_all(question.nested_questions, answers, cooperative),
          else: nil

      if not is_nil(answer) and answer != "" do
        filled_template =
          question.result_template
          |> fill(answer, question.answer_type)
          |> fill(
            cooperative,
            :cooperative
          )

        {filled_template, nested_filled_templates}
      end
    end)
    |> Enum.filter(&(!is_nil(&1)))
    |> Enum.with_index(fn {filled, nested_filled}, index ->
      article_number = to_string(index + 1)
      filled_with_article_number = fill(filled, article_number, :article_number)
      {filled_with_article_number, nested_filled}
    end)
  end

  def fill(template, answer, :multiple) do
    String.replace(template, "{OPTIONS}", Enum.join(Enum.reverse(answer), ", "))
  end

  def fill(template, answer, :text) do
    String.replace(template, "{TEXT}", answer)
  end

  def fill(template, answer, :exclusive) do
    if answer == "SI" do
      String.replace(template, "{OPTIONS}", answer)
    else
      ""
    end
  end

  def fill(template, cooperative, :cooperative) do
    String.replace(template, "{COOPERATIVE}", cooperative.name)
  end

  def fill(template, number, :article_number) do
    String.replace(template, "{NUMBER}", number)
  end
end
