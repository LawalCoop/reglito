defmodule ReglitoWeb.ChaptersSelectionsLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="w-full flex justify-center items-center pt-52 gap-4">
      <div class="flex flex-col gap-2 w-1/2 items-end text-justify">
        <p class="text-2xl font-bold">
          ¿Qué aspectos de tu cooperativa querés reglamentar?
        </p>
        <p class="text-xl">
          Elegí los que consideres, no es obligatorio que sean todos.
        </p>
        <%= if !Enum.empty?(@selected_chapters) do %>
          <div class="w-full pl-48 mt-5">
            <p class="text-xl font-bold">
              Capitulos seleccionados:
            </p>
            <%= for chapter <- @selected_chapters do %>
              <p><%= chapter %></p>
            <% end %>
          </div>
        <% else %>
          <p class="flex text-red-700 gap-2 justify-center items-center">
            <.icon class="text-red-700" name="hero-exclamation-triangle" />
            Todavia no seleccionaste ningún capitulo
          </p>
        <% end %>
      </div>

      <div id="chapter_to_select" class="w-1/2 ">
        <%= if @selection_status == :done do %>
          <div class=" flex flex-col items-center gap-4 px-24">
            <p class="flex flex-col justify-center items-center text-2xl font-bold">
              <.icon class="w-12 h-12 text-green-700" name="hero-check-circle" />
              Completaste la selección de capitulos
            </p>
            <button class="w-28 bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
              <.link href="/start">Siguiente</.link>
            </button>
          </div>
        <% else %>
          <div class="px-24">
            <p class="font-bold text-xl">
              <%= @chapters
              |> Enum.at(@current_chapter_index)
              |> Map.get("name") %>
            </p>
            <p>
              <%= @chapters
              |> Enum.at(@current_chapter_index)
              |> Map.get("description") %>
            </p>
            <div class="w-full flex justify-end gap-5 pr-10">
              <button class="text-red-800" phx-click="chapter_dropped">
                <.icon class="w-8 h-8" name="hero-x-circle" />
              </button>
              <button class=" text-green-800" phx-click="chapter_selected">
                <.icon class="w-8 h-8" name="hero-check-circle" />
              </button>
            </div>
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    chapters =
      case File.read("./chapter_descriptions.json") do
        {:ok, content} ->
          # Parsear el contenido JSON
          case Jason.decode(content) do
            {:ok, json_data} ->
              json_data

            {:error, error} ->
              IO.puts("Error al parsear el JSON: #{error}")
          end

        {:error, reason} ->
          IO.puts("Error al leer el archivo: #{reason}")
      end

    socket =
      socket
      |> assign(:selection_status, :started)
      |> assign(:chapters, chapters)
      |> assign(:selected_chapters, [])
      |> assign(:current_chapter_index, 0)

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
        |> assign(:selection_status, :done)

      {:noreply, socket}
    else
      socket =
        socket
        |> assign(
          :selected_chapters,
          Enum.reverse([
            [
              chapters
              |> Enum.at(current_chapter_index)
              |> Map.get("name")
            ]
            | selected_chapters
          ])
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