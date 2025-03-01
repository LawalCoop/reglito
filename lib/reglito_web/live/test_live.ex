defmodule ReglitoWeb.TestLive do
  use ReglitoWeb, :live_view

  alias Reglito.Template
  alias Reglito.Questions
  alias Reglito.AnswerForm

  def render(assigns) do
    ~H"""
    <div class="mx-40 my-10">
      <.form for={@form} phx-change="validate" phx-submit="save">
        <.button>Siguiente</.button>
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
    questions = Questions.all()
    form = AnswerForm.build(questions)

    socket =
      socket
      |> assign(:questions, questions)
      |> assign(:form, to_form(form))
      |> assign(:result, [])

    {:ok, socket}
  end

  def handle_event("validate", params_with_target, socket) do
    params = Map.delete(params_with_target, "_target")

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
