defmodule ReglitoWeb.TestLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-40 my-10">
      <.form for={@form} phx-change="validate" phx-submit="save">
        <.render_questions form={@form} questions={@questions} />

        <.button>Save</.button>
      </.form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    questions = [
      %{
        field_name: :favorite_dishes,
        question: "¿Cuales son tus platos favoritos?",
        answer_type: :multiple,
        options: ["pizza", "hamburguesa", "ensalada"],
        nested_questions: nil
      },
      %{
        field_name: :favorite_color,
        question: "¿Cuales son tus colores favoritos?",
        answer_type: :multiple,
        options: ["rojo", "azul", "amarillo"],
        nested_questions: [
          %{
            field_name: :quantity,
            question: "¿Cantidad de camisetas de ese color?",
            answer_type: :number,
            options: nil,
            nested_questions: [
              %{
                field_name: :size,
                question: "¿Talla?",
                answer_type: :multiple,
                options: ["S", "M", "L"],
                nested_questions: nil
              }
            ]
          }
        ]
      },
      %{
        field_name: :like_cook,
        question: "¿Te gusta cocinar?",
        answer_type: :exclusive,
        options: ["si", "no"],
        nested_questions: nil
      },
      %{
        field_name: :name,
        question: "¿Cuál es tu nombre?",
        answer_type: :text,
        options: nil,
        nested_questions: nil
      },
      %{
        field_name: :age,
        question: "¿Cuál es tu edad?",
        answer_type: :number,
        options: nil,
        nested_questions: nil
      }
    ]

    form = build_form(questions)

    socket =
      socket
      |> assign(:questions, questions)
      |> assign(:form, to_form(form))

    {:ok, socket}
  end

  # -------------
  def handle_event("validate", _, socket) do
    {:noreply, assign(socket, :form, to_form(%{}))}
  end

  def handle_event("save", _, socket) do
    {:noreply, assign(socket, :form, to_form(%{}))}
  end

  # -------------
  def render_questions(assigns) do
    ~H"""
    <div class="">
      <%= for field <- fields(@questions) do %>
        <.custom_input form={@form} field={field} question={question(@questions, field)} />
        <%= if not is_nil(question(@questions, field).nested_questions) do %>
          <div class="ml-10">
            <.render_questions form={@form} questions={question(@questions, field).nested_questions} />
          </div>
        <% end %>
      <% end %>
    </div>
    """
  end

  # -------------
  def custom_input(%{question: %{answer_type: :multiple}} = assigns) do
    ~H"""
    <.input
      type="select"
      field={@form[@field]}
      options={@question.options}
      multiple={true}
      label={@question.question}
    />
    """
  end

  def custom_input(%{question: %{answer_type: :exclusive}} = assigns) do
    ~H"""
    <.input
      type="select"
      field={@form[@field]}
      options={@question.options}
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
    Enum.find(questions, fn question -> question.field_name == field end)
  end

  def fields(questions) do
    Enum.map(questions, fn question -> question.field_name end)
  end

  # -------------
  def build_form(questions, form \\ %{})

  def build_form([%{field_name: field_name, nested_questions: nil} | tail], form) do
    new_form = Map.put(form, Atom.to_string(field_name), nil)
    build_form(tail, new_form)
  end

  def build_form([%{field_name: field_name, nested_questions: nested_questions} | tail], form) do
    new_form = Map.put(form, Atom.to_string(field_name), nil)
    build_form(tail ++ nested_questions, new_form)
  end

  def build_form([], form) do
    form
  end
end
