defmodule ReglitoWeb.Components.AnswerInputs do
  use Phoenix.LiveComponent

  import ReglitoWeb.CoreComponents

  alias Reglito.AnswerForm
  alias Reglito.Questions

  def render(assigns) do
    ~H"""
    <div class="">
      <.form for={@form} phx-change="validate" phx-submit="save" phx-target={@myself}>
        <%= for question_to_render <- @questions do %>
          <.answer_input
            hidden={question_to_render.key != @question.key}
            form={@form}
            field={question_to_render.key}
            question={question_to_render}
          />
          <%= if not is_nil(question_to_render.nested_questions) and not question_to_render.key != @question.key do %>
            <div class="ml-10">
              <.nested_answer_inputs
                hidden={false}
                form={@form}
                questions={question_to_render.nested_questions}
              />
            </div>
          <% end %>
        <% end %>

        <div class="w-full flex justify-between mt-5">
          <button
            name="save"
            value="previous_question"
            class="bg-blue-500 text-sm hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
          >
            <.icon name="hero-chevron-left" /> Volver
          </button>
          <%= if @is_the_last_one do %>
            <button
              name="save"
              value="to_check"
              class="flex justify-center text-sm bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
            >
              Revisar <.icon name="hero-chevron-right" />
            </button>
          <% else %>
            <button
              name="save"
              value="next_question"
              class="flex justify-center text-sm bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
            >
              Siguiente <.icon name="hero-chevron-right" />
            </button>
          <% end %>
        </div>
      </.form>
    </div>
    """
  end

  # --- HANDLERS ---

  def update(assigns, socket) do
    questions = assigns.questions
    form = AnswerForm.build(questions)
    question_number = 0

    socket =
      socket
      |> assign(:questions, questions)
      |> assign(:form, to_form(form))
      |> assign(:question_number, question_number)
      |> assign(:question, Enum.at(questions, question_number))
      |> assign(:is_the_last_one, false)

    {:ok, socket}
  end

  def handle_event("validate", params_with_target, socket) do
    params = Map.delete(params_with_target, "_target")

    send(self(), {:new_value, params})

    {:noreply, socket}
  end

  def handle_event("save", %{"save" => "previous_question"}, socket) do
    new_question_number = socket.assigns.question_number - 1

    if new_question_number < 0 do
      {:noreply, socket}
    else
      socket =
        socket
        |> assign(:question_number, new_question_number)
        |> assign(:question, Enum.at(socket.assigns.questions, new_question_number))
        |> assign(:is_the_last_one, false)

      {:noreply, socket}
    end
  end

  def handle_event("save", %{"save" => "next_question"}, socket) do
    question_quantity = length(socket.assigns.questions) - 1
    new_question_number = socket.assigns.question_number + 1

    if new_question_number == question_quantity do
      socket =
        socket
        |> assign(:question_number, new_question_number)
        |> assign(:question, Enum.at(socket.assigns.questions, new_question_number))
        |> assign(:is_the_last_one, true)

      {:noreply, socket}
    else
      socket =
        socket
        |> assign(:question_number, new_question_number)
        |> assign(:question, Enum.at(socket.assigns.questions, new_question_number))

      {:noreply, socket}
    end
  end

  # --- HANDLERS ---

  defp nested_answer_inputs(assigns) do
    ~H"""
    <%= for %{key: key} = question <- Questions.all() do %>
      <.answer_input hidden={@hidden} form={@form} field={key} question={question} />
      <%= if not is_nil(question.nested_questions) do %>
        <div class="ml-10">
          <.nested_answer_inputs hidden={@hidden} form={@form} questions={question.nested_questions} />
        </div>
      <% end %>
    <% end %>
    """
  end

  defp answer_input(%{question: %{answer_type: :multiple}} = assigns) do
    ~H"""
    <.input
      hidden={@hidden}
      type="select"
      field={@form[@field]}
      options={@question.options}
      multiple={true}
      label={@question.question}
    />
    """
  end

  defp answer_input(%{question: %{answer_type: :exclusive}} = assigns) do
    ~H"""
    <.input
      hidden={@hidden}
      type="select"
      field={@form[@field]}
      options={@question.options}
      label={@question.question}
    />
    """
  end

  defp answer_input(%{question: %{answer_type: :text}} = assigns) do
    ~H"""
    <.input hidden={@hidden} type="text" field={@form[@field]} label={@question["question"]} />
    """
  end

  defp answer_input(%{question: %{answer_type: :number}} = assigns) do
    ~H"""
    <.input hidden={@hidden} type="number" field={@form[@field]} label={@question["question"]} />
    """
  end
end
