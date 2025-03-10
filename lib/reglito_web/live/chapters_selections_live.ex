defmodule ReglitoWeb.ChaptersSelectionsLive do
  alias Reglito.Chapters
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div id="container" class="h-full flex flex-col">
      <div id="header" class="flex justify-between items-center w-full py-10 px-10">
        <div id="header_left" class="w-[50%] flex flex-col items-end pr-10">
          <p class="text-2xl font-bold">
            ¿Qué aspectos de <%= @cooperative_name %> querés reglamentar?
          </p>
          <p class="text-xl">
            Elegí los que consideres, no es obligatorio que sean todos.
          </p>
        </div>

        <div id="header_right" class="w-[50%] flex flex-col items-start pl-10">
          <p class="text-xl font-bold mb-2">
            Capitulos seleccionados:
          </p>
          <%= if !Enum.empty?(@selected_chapters) do %>
            <p><%= @selected_chapters |> Enum.map(& &1.name) |> Enum.join(", ") %></p>
          <% else %>
            <p class="text-red-700 gap-2">
              <.icon class="text-red-700" name="hero-exclamation-triangle" />
              Todavia no seleccionaste ningún capitulo
            </p>
          <% end %>
        </div>
      </div>

      <div id="chapter_selection" class="grow item flex flex-col justify-center items-center px-80">
        <%= if @selection_status == :done do %>
          <p class="flex flex-col justify-center items-center text-2xl font-bold">
            <img class="h-16 mb-5" src={~p"/images/success.gif"} alt="success" />
            Completaste la selección de capitulos
          </p>
          <p class="text-xl">
            ahora vamos a contestar las preguntas de cada capitulo
          </p>
        <% else %>
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
        <% end %>
      </div>

      <div id="footer" class="flex items-center justify-center gap-10 p-10">
        <%= if @selection_status == :done do %>
          <button class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
            <.link href={
              ~p"/start?#{%{selected_chapters: Enum.reverse(Enum.map(@selected_chapters, fn chapter -> chapter.code end))}}"
            }>
              Siguiente <.icon name="hero-chevron-right" />
            </.link>
          </button>
        <% else %>
          <button
            phx-click="chapter_dropped"
            class="bg-red-500 hover:bg-red-400 text-white font-bold py-2 px-4 border-b-4 border-red-700 hover:border-red-500 rounded"
          >
            No reglamentar <.icon class="w-8 h-8" name="hero-x-mark" />
          </button>
          <button
            phx-click="chapter_selected"
            class="bg-green-500 hover:bg-green-400 text-white font-bold py-2 px-4 border-b-4 border-green-700 hover:border-green-500 rounded"
          >
            Reglamentar <.icon class="w-8 h-8" name="hero-check" />
          </button>
        <% end %>
      </div>
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
