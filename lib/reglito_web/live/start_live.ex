defmodule ReglitoWeb.StartLive do
  alias Reglito.Template
  alias Reglito.Chapters
  use ReglitoWeb, :live_view

  alias Reglito.Questions
  alias ReglitoWeb.Components.AnswerInputs

  def render(assigns) do
    ~H"""
    <div class="flex flex-col w-full">
      <div class="flex mt-4 px-8">
        <div class="flex-1 p-4">
          <h1 class="text-xl font-bold">
            Reglamento interno de la cooperativa: <%= @cooperative.name %>
          </h1>
        </div>

        <div class="flex-1">
          <p class="font-bold mb-2">
            Preguntas: <%= @current_section_index + 1 %> de <%= length(@questions) %>
          </p>
          <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-300">
            <div
              class="bg-blue-600 h-2.5 rounded-full"
              style={"width: #{@progress_multiplier  * (@current_section_index + 1)}%"}
            >
            </div>
          </div>
        </div>
      </div>

      <div class="flex-1 mx-10 mt-5 mb-5">
        <div class="px-5 py-4 min-h-64 max-h-64  overflow-y-scroll bg-gray-100 rounded-md w-full flex flex-col">
          <%= if Enum.empty?(@rules) do %>
            <div class="flex justify-center mt-24">
              <h1 class="text-xl font-bold">
                Responda la primer pregunta para comenzar...
              </h1>
            </div>
          <% else %>
            <%= for rule <- @rules do %>
              <div>
                <p><%= rule %></p>
              </div>
            <% end %>
          <% end %>
        </div>
      </div>

      <div class="mx-10">
        <p class="font-bold mb-2">
          Capitulo: <%= @chapter_name %>
        </p>
        <.live_component module={AnswerInputs} id="answers" questions={@questions} />
      </div>
    </div>
    """
  end

  def mount(
        %{"selected_chapters" => selected_chapters},
        %{"cooperative_name" => cooperative_name, "registration_number" => registration_number},
        socket
      ) do
    selected_chapters = Enum.map(selected_chapters, &String.to_existing_atom/1)

    cooperative = %{name: cooperative_name, registration_number: registration_number}
    chapters_by_code = Chapters.by_code()
    questions = Questions.selected_chapters_questions(selected_chapters)
    progress_multiplier = 100 / length(questions)
    start_index = 0

    socket =
      socket
      |> assign(:cooperative, cooperative)
      |> assign(:chapters_by_code, chapters_by_code)
      |> assign(:questions, questions)
      |> assign(:rules, [])
      |> assign(:chapter_name, "")
      |> assign(:current_section_index, start_index)
      |> assign(:is_the_last_one, false)
      |> assign(:progress_multiplier, progress_multiplier)

    {:ok, socket}
  end

  def handle_info({:to_check}, socket) do
    {:noreply,
     push_navigate(socket,
       to: "/check?articles=#{Base.encode64(Jason.encode!(socket.assigns.rules))}"
     )}
  end

  def handle_info({:new_value, answers}, socket) do
    rules =
      Template.fill_all(socket.assigns.questions, answers, socket.assigns.cooperative)
      |> Template.render()

    socket =
      socket
      |> assign(:rules, rules)

    {:noreply, socket}
  end

  def handle_info({:update_chapter_code, %{code: code}}, socket) do
    chapter_name =
      Map.get(socket.assigns.chapters_by_code, code)
      |> Map.get(:name)

    socket =
      socket
      |> assign(:chapter_name, chapter_name)

    {:noreply, socket}
  end

  def handle_info({:new_question, new_question_number}, socket) do
    {:noreply, assign(socket, :current_section_index, new_question_number)}
  end
end
