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
          <div class="bg-blue-600 h-2.5 rounded-full" style="width: 50%"></div>
        </div>
      </div>

      <div class="flex">
        <div class="w-1/2 h-full flex pl-20">
          <div class="flex flex-col w-full items-start pt-32">
            <p class="font-bold text-2xl mb-5">
              <%= question(@sections, @current_section_index) %>
            </p>
            <div>
              <%= for option <- options(@sections, @current_section_index) do %>
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
          <div id="" class="w-full flex flex-col justify-center">
            <%= for {article, i} <- Enum.with_index(@articles) do %>
              <p id={"#{i}"}><%= article %></p>
            <% end %>
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

    sections =
      chapters
      |> Enum.flat_map(fn {chapter_key, %{"sections" => sections}} ->
        Enum.map(sections, fn section ->
          Map.put(section, "chapter", chapter_key)
        end)
      end)

    socket =
      socket
      |> assign(:sections, sections)
      |> assign(:current_section_index, 0)
      |> assign(:options_selected, [])
      |> assign(:articles, [])

    {:ok, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_selected, "value" => _value},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    options_selected = socket.assigns.options_selected

    options_selected =
      if selection_type == "exclusive" do
        [option_selected]
      else
        [
          option_selected
          | options_selected
        ]
      end

    socket =
      socket
      |> assign(:options_selected, options_selected)
      |> assign_articles()

    {:noreply, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_to_remove},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    options_selected = socket.assigns.options_selected

    options_selected =
      if selection_type == "exclusive" do
        []
      else
        Enum.reject(options_selected, fn option_selected ->
          option_selected == option_to_remove
        end)
      end

    socket =
      socket
      |> assign(:options_selected, options_selected)
      |> assign_articles()

    {:noreply, socket}
  end

  def handle_event("next_section", _, socket) do
    current_section_index = socket.assigns.current_section_index

    # TODO: falta contemplar el caso en el que esta en la
    # ultima section y tiene que pasar al proximo capitulo

    # TODO: si esta al final del todo no navegar

    socket =
      socket
      |> assign(:current_section_index, current_section_index + 1)
      |> assign(:options_selected, [])

    {:noreply, socket}
  end

  def handle_event("previous_section", _, socket) do
    current_section_index = socket.assigns.current_section_index

    # TODO: falta contemplar el caso en el que esta en la
    # primera section y tiene que pasar al capitulo anterior

    # TODO: si esta al principio del todo no navegar

    socket =
      socket
      |> assign(:current_section_index, current_section_index - 1)
      |> assign(:options_selected, [])

    {:noreply, socket}
  end

  defp assign_articles(socket) do
    articles = socket.assigns.articles
    sections = socket.assigns.sections
    current_section_index = socket.assigns.current_section_index
    options_selected = socket.assigns.options_selected
    current_section = current_section(sections, current_section_index)

    article_number =
      if length(articles) < current_section_index,
        do: length(articles) + 1,
        else: current_section_index + 1

    new_rule_already_exist =
      !is_nil(Enum.at(articles, current_section_index))

    rule = fill_template(current_section, options_selected, article_number)

    new_articles =
      if new_rule_already_exist do
        List.replace_at(articles, current_section_index, rule)
      else
        articles ++ [rule]
      end

    socket
    |> assign(:articles, new_articles)
  end

  defp fill_template(current_section, options_selected, article_number) do
    template = current_section["result_template"]

    case current_section["aswer_type"] do
      "multiple" ->
        template
        |> String.replace("{COOPERATIVE}", "Lawal Cooperativa Tecnologica")
        |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(options_selected), ", "))
        |> String.replace("{NUMBER}", to_string(article_number))

      "exclusive" ->
        if options_selected == ["SI"] do
          template
          |> String.replace("{NUMBER}", to_string(article_number))
        else
          nil
        end

      "multiple_with_exclusive" ->
        template
        |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(options_selected), ", "))
        |> String.replace("{NUMBER}", to_string(article_number))
    end
  end

  def manipular_string(str, conservar_contenido \\ true) do
    if conservar_contenido do
      # Remueve las llaves pero deja el contenido dentro
      Regex.replace(~r/\{([^}]+)\}/, str, "\\1")
    else
      # Elimina todo el contenido entre las llaves
      Regex.replace(~r/\{[^}]+\}/, str, "")
    end
  end

  defp current_section(sections, index) do
    Enum.at(sections, index)
  end

  defp question(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("question")
  end

  defp options(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("options")
  end

  defp aswer_type(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("aswer_type")
  end
end
