defmodule ReglitoWeb.ChaptersSelectionsLive do
  alias Reglito.Chapters
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col justify-center items-center">
      <%= if @selection_status == :done do %>
        <div class=" flex flex-col items-center gap-4 px-24 mt-32">
          <p class="flex flex-col justify-center items-center text-2xl font-bold">
            <img class="h-16 mb-5" src={~p"/images/success.gif"} alt="success" />
            Completaste la selección de capitulos
          </p>
          <button class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
            <.link href={
              ~p"/start?#{%{selected_chapters: Enum.reverse(Enum.map(@selected_chapters, fn chapter -> chapter.code end))}}"
            }>
              Siguiente <.icon name="hero-chevron-right" />
            </.link>
          </button>
        </div>
      <% else %>
        <div class="max-w-[40%] flex flex-col my-12">
          <div class="flex flex-col mb-5">
            <p class="text-2xl font-bold">
              ¿Qué aspectos de <%= @cooperative_name %> querés reglamentar?
            </p>
            <p class="text-xl">
              Elegí los que consideres, no es obligatorio que sean todos.
            </p>
          </div>
          <div class="border-l-4 border-black pl-8 mt-8 flex h-10 justify-center items-center">
            <%= if !Enum.empty?(@selected_chapters) do %>
              <div class="w-full">
                <p class="text-xl font-bold">
                  Capitulos seleccionados:
                </p>
                <p><%= @selected_chapters |> Enum.map(& &1.name) |> Enum.join(", ") %></p>
              </div>
            <% else %>
              <p class="flex text-red-700 gap-2 justify-center items-center">
                <.icon class="text-red-700" name="hero-exclamation-triangle" />
                Todavia no seleccionaste ningún capitulo
              </p>
            <% end %>
          </div>
        </div>

        <div id="chapter_to_select" class="w-[60%] justify-center items-center">
          <div class="px-24">
            <p class="font-bold text-xl">
              <%= @chapters
              |> Enum.at(@current_chapter_index)
              |> Map.get(:name) %>
            </p>
            <p>
              <%= @chapters
              |> Enum.at(@current_chapter_index)
              |> Map.get(:description) %>
            </p>
            <div class="w-full flex justify-center gap-5 mt-5">
              <button class="text-red-700 hover:text-red-900" phx-click="chapter_dropped">
                <.icon class="w-8 h-8" name="hero-x-circle" />
              </button>
              <button class=" text-green-700 hover:text-green-900" phx-click="chapter_selected">
                <.icon class="w-8 h-8" name="hero-check-circle" />
              </button>
            </div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def mount(_params, session, socket) do
    cooperative_name = session["cooperative_name"]
    registration_number = session["registration_number"]
    chapters = Chapters.all()

    socket =
      socket
      |> assign(:selection_status, :started)
      |> assign(:chapters, chapters)
      |> assign(:selected_chapters, [])
      |> assign(:current_chapter_index, 0)
      |> assign(:cooperative_name, cooperative_name)
      |> assign(:registration_number, registration_number)

    {:ok, socket}
  end

  def handle_event("chapter_selected", _, socket) do
    chapters = socket.assigns.chapters
    selected_chapters = socket.assigns.selected_chapters
    current_chapter_index = socket.assigns.current_chapter_index
    new_current_index = current_chapter_index + 1

    if new_current_index >= length(chapters) do
      socket =
        socket
        |> assign(
          :selected_chapters,
          [
            Enum.at(chapters, current_chapter_index)
            | selected_chapters
          ]
        )
        |> assign(:selection_status, :done)

      {:noreply, socket}
    else
      socket =
        socket
        |> assign(
          :selected_chapters,
          [
            Enum.at(chapters, current_chapter_index)
            | selected_chapters
          ]
        )
        |> assign(:current_chapter_index, new_current_index)

      {:noreply, socket}
    end
  end

  def handle_event("chapter_dropped", _, socket) do
    chapters = socket.assigns.chapters
    current_chapter_index = socket.assigns.current_chapter_index
    new_current_index = current_chapter_index + 1

    if new_current_index >= length(chapters) do
      socket =
        socket
        |> assign(:selection_status, :done)

      {:noreply, socket}
    else
      socket =
        socket
        |> assign(:current_chapter_index, new_current_index)

      {:noreply, socket}
    end
  end
end
