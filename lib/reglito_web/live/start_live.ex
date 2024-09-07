defmodule ReglitoWeb.StartLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full w-full">
      <div class="px-20">
        <div class="p-4">
          <!-- TODO: Mostrar informacion de la cooperativa no hardcodeada -->
          <p class="">Reglamento interno de:</p>
          <p class="text-xl font-bold">Lawal Cooperativa Tecnologica Ltda.</p>
        </div>
        <!-- TODO: hacer andar la barra de progreso -->
        <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-300">
          <div class="bg-blue-600 h-2.5 rounded-full" style="width: 5%"></div>
        </div>
      </div>

      <div class="flex">
        <div class="w-1/2 h-full flex pl-20">
          <div class="flex flex-col w-full items-start pt-32">
            <p class="font-bold text-2xl mb-5">
              <%= @current_section["question"] %>
            </p>
            <div>
              <%= for option <- @current_section["options"] do %>
                <p>
                  <input
                    checked={
                      Enum.any?(@options_selected, fn selected_option -> selected_option == option end)
                    }
                    phx-click="option_selected"
                    type="checkbox"
                    name={option}
                    id={option}
                    phx-value-option-selected={option}
                  />
                  <%= option %>
                </p>
              <% end %>
            </div>
            <div class="w-full flex justify-between mt-5">
              <button
                phx-click="previous_section"
                class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
              >
                <.icon name="hero-chevron-left" /> Volver
              </button>
              <button
                phx-click="next_section"
                class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
              >
                Siguiente <.icon name="hero-chevron-right" />
              </button>
            </div>
          </div>
        </div>
        <div class="w-1/2 h-full overflow-y-scroll m-5 p-5 bg-gray-100 rounded-xl">
          <div class="w-full flex justify-center">
            <div>
              <%= for {_i, articles_by_chapters} <- @articles do %>
                <%= for {_i, articles} <- articles_by_chapters do %>
                  <p><%= articles %></p>
                <% end %>
              <% end %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"selected_chapters" => selected_chapters}, _session, socket) do
    # TODO: mover el fetch de la info a su propio modulo
    chapters =
      case File.read("./chapters_data.json") do
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

    chapters =
      chapters
      |> Enum.filter(fn {key, _value} -> key in selected_chapters end)
      |> Enum.into(%{})

    start_index = 0

    socket =
      socket
      |> assign(:chapters, chapters)
      |> assign(:selected_chapters, selected_chapters)
      |> assign(:chapter_index, start_index)
      |> assign(:section_index, start_index)
      |> assign_current_section()
      |> assign(:options_selected, [])
      |> assign(:articles, %{})
      |> assign(:to_display, [])

    {:ok, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_selected, "value" => _value},
        socket
      ) do
    options_selected = socket.assigns.options_selected

    options_selected = [
      option_selected
      | options_selected
    ]

    socket =
      socket
      |> assign(:options_selected, options_selected)
      |> assign_rules

    {:noreply, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_to_remove},
        socket
      ) do
    options_selected = socket.assigns.options_selected

    options_selected =
      Enum.reject(options_selected, fn option_selected -> option_selected == option_to_remove end)

    socket =
      socket
      |> assign(:options_selected, options_selected)
      |> assign_rules

    {:noreply, socket}
  end

  def handle_event("next_section", _, socket) do
    section_index = socket.assigns.section_index

    socket =
      socket
      |> assign(:section_index, section_index + 1)
      |> assign_current_section

    {:noreply, socket}
  end

  def handle_event("previous_section", _, socket) do
    section_index = socket.assigns.section_index

    socket =
      socket
      |> assign(:section_index, section_index - 1)
      |> assign_current_section

    {:noreply, socket}
  end

  def assign_current_section(socket) do
    selected_chapters = socket.assigns.selected_chapters
    chapter_index = socket.assigns.chapter_index
    section_index = socket.assigns.section_index
    chapters = socket.assigns.chapters

    chapter_name = Enum.at(selected_chapters, chapter_index)

    current_section =
      chapters
      |> Map.fetch!(chapter_name)
      |> Map.fetch!("sections")
      |> Enum.at(section_index)

    assign(socket, :current_section, current_section)
  end

  defp assign_rules(socket) do
    chapter_index = socket.assigns.chapter_index
    section_index = socket.assigns.section_index
    articles = socket.assigns.articles
    options_selected = socket.assigns.options_selected
    current_section = socket.assigns.current_section

    template = current_section["result_template"]

    template_with_options =
      template
      |> String.replace("{COOPERATIVE}", "Lawal Cooperativa Tecnologica")
      |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(options_selected), ", "))
      |> String.replace("{NUMBER}", to_string(section_index + 1))

    chapter_articles = Map.get(articles, to_string(chapter_index), %{})
    section_articles = Map.put(chapter_articles, to_string(section_index), template_with_options)
    articles = Map.put(articles, to_string(chapter_index), section_articles)

    assign(socket, :articles, articles)
  end
end
