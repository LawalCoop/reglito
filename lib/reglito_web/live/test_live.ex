defmodule ReglitoWeb.TestLive do
  alias Reglito.Question
  alias Reglito.Template
  use ReglitoWeb, :live_view

  alias Reglito.Chapters
  alias Reglito.AnswerForm

  import ReglitoWeb.Components.AnswerInputs

  def render(assigns) do
    ~H"""
    <div class="mx-40 my-10">
      <.form for={@form} phx-change="validate" phx-submit="save">
        <.nested_answer_inputs form={@form} questions={@questions} />
        <.button>Save</.button>
      </.form>

      <%= for {res, index} <- Enum.with_index(@result, 1) do %>
        <div>
          <p><%= String.replace(res, "{NUMBER}", to_string(index)) %></p>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    questions = Chapters.sections()
    form = AnswerForm.build(questions)

    socket =
      socket
      |> assign(:questions, questions)
      |> assign(:form, to_form(form))
      |> assign(:result, [])

    {:ok, socket}
  end

  # -------------
  def handle_event("validate", _, socket) do
    {:noreply, assign(socket, :form, to_form(%{}))}
  end

  def handle_event("save", params, socket) do
    result =
      params
      |> Enum.map(fn {key, answer} ->
        Template.fill(key, answer)
      end)

    socket =
      socket
      |> assign(:result, result)

    {:noreply, socket}
  end
end
