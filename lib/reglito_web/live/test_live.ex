defmodule ReglitoWeb.TestLive do
  alias Reglito.Chapters
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-40 my-10">
      <.form for={@form} phx-change="validate" phx-submit="save">
        <.render_questions form={@form} questions={@questions} />
        <.button>Save</.button>
      </.form>
      <%= @result %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    questions =
      Chapters.read_chapters_data()
      |> Enum.flat_map(fn {_chapter_key, %{"sections" => sections}} ->
        sections
      end)
      |> IO.inspect(label: "QUESTIONSSS")

    form = build_form(questions)

    socket =
      socket
      |> assign(:questions, questions)
      |> assign(:form, to_form(form))
      |> assign(:result, "NADA TODAVIA")

    {:ok, socket}
  end

  # -------------
  def handle_event("validate", _, socket) do
    {:noreply, assign(socket, :form, to_form(%{}))}
  end

  def handle_event("save", params, socket) do
    result =
      params
      |> Enum.map(fn {key, values} ->
        Enum.find(socket.assigns.questions, fn question -> question["field_name"] == key end)[
          "result_template"
        ]
        |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(values), ", "))
      end)

    socket =
      socket
      |> assign(:result, result)

    {:noreply, socket}
  end

  # -------------
  def render_questions(assigns) do
    ~H"""
    <div class="">
      <%= for field <- fields(@questions) do %>
        <.custom_input form={@form} field={field} question={question(@questions, field)} />
        <%= if not is_nil(question(@questions, field)["nested_questions"]) do %>
          <div class="ml-10">
            <.render_questions
              form={@form}
              questions={question(@questions, field)["nested_questions"]}
            />
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  # -------------
  def custom_input(%{question: %{"answer_type" => "multiple"}} = assigns) do
    ~H"""
    <.input
      type="select"
      field={@form[@field]}
      options={@question["options"]}
      multiple={true}
      label={@question["question"]}
    />
    """
  end

  def custom_input(%{question: %{answer_type: :exclusive}} = assigns) do
    ~H"""
    <.input
      type="select"
      field={@form[@field]}
      options={@question["options"]}
      label={@question.question}
    />
    """
  end

  def custom_input(%{question: %{answer_type: :text}} = assigns) do
    ~H"""
    <.input type="text" field={@form[@field]} label={@question.question} />
    """
  end

  def custom_input(%{question: %{answer_type: :number}} = assigns) do
    ~H"""
    <.input type="number" field={@form[@field]} label={@question.question} />
    """
  end

  # -------------

  def question(questions, field) do
    Enum.find(questions, fn question -> question["field_name"] == field end)
  end

  def fields(questions) do
    Enum.map(questions, fn question -> question["field_name"] end)
  end

  # -------------
  def build_form(questions, form \\ %{})

  def build_form([%{"field_name" => field_name, "nested_questions" => nil} | tail], form) do
    new_form = Map.put(form, field_name, nil)
    build_form(tail, new_form)
  end

  def build_form(
        [%{"field_name" => field_name, "nested_questions" => nested_questions} | tail],
        form
      ) do
    new_form = Map.put(form, field_name, nil)
    build_form(tail ++ nested_questions, new_form)
  end

  def build_form([], form) do
    form
  end
end
