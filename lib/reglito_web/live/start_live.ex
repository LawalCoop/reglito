defmodule ReglitoWeb.StartLive do
  alias Reglito.Template
  alias Reglito.Chapters
  use ReglitoWeb, :live_view

  alias Reglito.Questions
  alias ReglitoWeb.Components.AnswerInputs

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full w-full">
      <div class="px-20">
        <div class="p-4">
          <p class="">Reglamento interno de:</p>
          <p class="text-xl font-bold"><%= @cooperative.name %></p>
        </div>
        <p class="font-bold mb-2">
          Capitulo: <%= @chapter_name %>
        </p>
        <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-300">
          <div
            class="bg-blue-600 h-2.5 rounded-full"
            style={"width: #{@progress_multiplier  * (@current_section_index + 1)}%"}
          >
          </div>
        </div>
      </div>

      <div class="flex">
        <div class="w-1/2 h-full flex pl-20">
          <div class="flex flex-col w-full pt-5">
            <div class="font-bold text-2xl mb-5">
              <.live_component module={AnswerInputs} id="answers" questions={@questions} />
            </div>
          </div>
        </div>
        <div class="w-1/2 h-full overflow-y-scroll m-5 p-5 bg-gray-100 rounded-xl">
          <div class="w-full flex flex-col justify-center">
            <%= for {answer, index} <- Enum.with_index(@answers, 1) do %>
              <div>
                <p><%= String.replace(answer, "{NUMBER}", to_string(index)) %></p>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(
        %{"selected_chapters" => _selected_chapters},
        %{"cooperative_name" => cooperative_name, "registration_number" => registration_number},
        socket
      ) do
    progress_multiplier = 100 / length([1])
    start_index = 0
    cooperative = %{name: cooperative_name, registration_number: registration_number}
    chapters_by_code = Chapters.by_code()
    questions = Questions.all()

    socket =
      socket
      |> assign(:cooperative, cooperative)
      |> assign(:chapters_by_code, chapters_by_code)
      |> assign(:questions, questions)
      |> assign(:answers, [])
      |> assign(:chapter_name, "")
      |> assign(:current_section_index, start_index)
      |> assign(:is_the_last_one, false)
      |> assign(:progress_multiplier, progress_multiplier)

    {:ok, socket}
  end

  def handle_info({:new_value, answers}, socket) do
    answers =
      answers
      |> Enum.map(fn {key, answer} ->
        Template.fill(key, answer)
      end)

    socket =
      socket
      |> assign(:answers, answers)

    {:noreply, socket}
  end

  def handle_info({:update_chapter_code, %{code: code}}, socket) do
    chapter_name = Map.get(socket.assigns.chapters_by_code, code)
    |> Map.get(:name)

    socket =
      socket
      |> assign(:chapter_name, chapter_name)

    {:noreply, socket}
  end
end
