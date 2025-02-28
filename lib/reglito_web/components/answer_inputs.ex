defmodule ReglitoWeb.Components.AnswerInputs do
  use Phoenix.Component

  import ReglitoWeb.CoreComponents

  alias Reglito.Question

  def nested_answer_inputs(assigns) do
    ~H"""
    <div class="">
      <%= for field <- Question.fetch_question_keys(@questions) do %>
        <.answer_input
          form={@form}
          field={field}
          question={Question.fetch_question(@questions, field)}
        />
        <%= if not is_nil(Question.fetch_nested_questions(@questions, field)) do %>
          <div class="ml-10">
            <.nested_answer_inputs
              form={@form}
              questions={Question.fetch_nested_questions(@questions, field)}
            />
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  def answer_input(%{question: %{"answer_type" => "multiple"}} = assigns) do
    ~H"""
    <.input
      class="w-full"
      type="select"
      field={@form[@field]}
      options={@question["options"]}
      multiple={true}
      label={@question["question"]}
    />
    """
  end

  def answer_input(%{question: %{"answer_type" => "exclusive"}} = assigns) do
    ~H"""
    <.input
      type="select"
      field={@form[@field]}
      options={@question["options"]}
      label={@question["question"]}
    />
    """
  end

  def answer_input(%{question: %{"answer_type" => "text"}} = assigns) do
    ~H"""
    <.input type="text" field={@form[@field]} label={@question["question"]} />
    """
  end

  def answer_input(%{question: %{"answer_type" => "number"}} = assigns) do
    ~H"""
    <.input type="number" field={@form[@field]} label={@question["question"]} />
    """
  end
end
