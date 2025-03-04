defmodule ReglitoWeb.Components.AnswerInputs do
  use Phoenix.LiveComponent

  import ReglitoWeb.CoreComponents

  alias Reglito.AnswerForm

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
          <%= if not is_nil(question_to_render.nested_questions) do %>
            <%= for nested_question_to_render <- question_to_render.nested_questions do %>
              <.answer_input
                hidden={question_to_render.key != @question.key}
                form={@form}
                field={nested_question_to_render.key}
                question={nested_question_to_render}
              />
            <% end %>
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
    question = Enum.at(questions, question_number)

    send_chapter_code(question.chapter)

    socket =
      socket
      |> assign(:questions, questions)
      |> assign(:form, to_form(form))
      |> assign(:question_number, question_number)
      |> assign(:question, question)
      |> assign(:is_the_last_one, false)

    {:ok, socket}
  end

  def handle_event("validate", params_with_target, socket) do
    answers = Map.delete(params_with_target, "_target")

    send(self(), {:new_value, answers})

    {:noreply, assign(socket, :form, to_form(answers))}
  end

  def handle_event("save", %{"save" => "previous_question"} = params, socket) do
    new_question_number = socket.assigns.question_number - 1
    answers = Map.delete(params, "save")

    socket =
      if new_question_number < 0 do
        socket
      else
        send(self(), {:new_question, new_question_number})

        socket
        |> assign(:question_number, new_question_number)
        |> assign(:question, Enum.at(socket.assigns.questions, new_question_number))
        |> assign(:is_the_last_one, false)
        |> assign(:form, to_form(answers))
      end

    {:noreply, socket}
  end

  def handle_event("save", %{"save" => "next_question"} = params, socket) do
    question_quantity = length(socket.assigns.questions) - 1
    new_question_number = socket.assigns.question_number + 1
    answers = Map.delete(params, "save")

    socket =
      socket
      |> assign(:question_number, new_question_number)
      |> assign(:question, Enum.at(socket.assigns.questions, new_question_number))
      |> assign(:form, to_form(answers))

    socket =
      if new_question_number == question_quantity,
        do: assign(socket, :is_the_last_one, true),
        else: socket

    send(self(), {:new_question, new_question_number})

    {:noreply, socket}
  end

  def handle_event("save", %{"save" => "to_check"}, socket) do
    send(self(), {:to_check})

    {:noreply, socket}
  end

  def send_chapter_code(code) do
    send(self(), {:update_chapter_code, %{code: code}})
  end

  # --- END HANDLERS ---

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
      options={[{"-", nil} | @question.options]}
      label={@question.question}
    />
    """
  end

  defp answer_input(%{question: %{answer_type: :text}} = assigns) do
    ~H"""
    <.input hidden={@hidden} type="text" field={@form[@field]} label={@question.question} />
    """
  end

  defp answer_input(%{question: %{answer_type: :number}} = assigns) do
    ~H"""
    <.input hidden={@hidden} type="number" field={@form[@field]} label={@question.question} />
    """
  end
end
