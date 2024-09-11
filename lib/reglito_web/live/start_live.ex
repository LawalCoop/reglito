defmodule ReglitoWeb.StartLive do
  alias Reglito.Chapters
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full w-full">
      <div class="px-20">
        <div class="p-4">
          <p class="">Reglamento interno de:</p>
          <p class="text-xl font-bold">Lawal Cooperativa Tecnologica Ltda.</p>
        </div>
        <p class="font-bold mb-2">
          Capitulo: <%= @chapter_name_by_code[chapter(@sections, @current_section_index)] %>
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
          <div class="flex flex-col w-full items-start pt-16">
            <p class="font-bold text-2xl mb-5">
              <%= question(@sections, @current_section_index) %>
            </p>
            <div>
              <%= for option <- options(@sections, @current_section_index) do %>
                <p>
                  <input
                    checked={Enum.any?(@aswer, fn selected_option -> selected_option == option end)}
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
            <%= if not is_nil(related_question(@sections, @current_section_index)) do %>
              <div class="mt-2">
                <p class="font-bold text-2xl mb-2">
                  <%= related_question(@sections, @current_section_index)["question"] %>
                </p>
                <div>
                  <%= for option <- related_question(@sections, @current_section_index)["options"] do %>
                    <p>
                      <input
                        checked={
                          Enum.any?(@aswer, fn selected_option -> selected_option == option end)
                        }
                        phx-click="related_option_selected"
                        type="checkbox"
                        name={option}
                        id={option}
                        phx-value-option-selected={option}
                      />
                      <%= option %>
                    </p>
                  <% end %>
                </div>
              </div>
            <% end %>

            <div class="w-full flex justify-between mt-5">
              <button
                phx-click="previous_section"
                class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
              >
                <.icon name="hero-chevron-left" /> Volver
              </button>
              <%= if @is_the_last_one do %>
                <button class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
                  <.link href="/check">
                    Revisar <.icon name="hero-chevron-right" />
                  </.link>
                </button>
              <% else %>
                <button
                  phx-click="next_section"
                  class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
                >
                  Siguiente <.icon name="hero-chevron-right" />
                </button>
              <% end %>
            </div>
          </div>
        </div>
        <div class="w-1/2 h-full overflow-y-scroll m-5 p-5 bg-gray-100 rounded-xl">
          <div class="w-full flex flex-col justify-center">
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
    chapters = Chapters.read_chapters_data()

    chapter_name_by_code =
      for %{"code" => code, "name" => name} <- Chapters.read_chapters_description(),
          into: %{},
          do: {code, name}

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

    progress_multiplier = 100 / length(sections)
    start_index = 0

    socket =
      socket
      |> assign(:progress_multiplier, progress_multiplier)
      |> assign(:is_the_last_one, false)
      |> assign(:sections, sections)
      |> assign(:current_section_index, start_index)
      |> assign(:aswer, [])
      |> assign(:related_question_aswer, [])
      |> assign(:articles, [])
      |> assign(:chapter_name_by_code, chapter_name_by_code)

    {:ok, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_selected, "value" => _value},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    aswer = socket.assigns.aswer

    aswer =
      if selection_type == "exclusive" do
        [option_selected]
      else
        [
          option_selected
          | aswer
        ]
      end

    socket =
      socket
      |> assign(:aswer, aswer)
      |> assign_articles()

    {:noreply, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_to_remove},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    aswer = socket.assigns.aswer

    aswer =
      if selection_type == "exclusive" do
        []
      else
        Enum.reject(aswer, fn option_selected ->
          option_selected == option_to_remove
        end)
      end

    socket =
      socket
      |> assign(:aswer, aswer)
      |> assign_articles()

    {:noreply, socket}
  end

  def handle_event(
        "related_option_selected",
        %{"option-selected" => option_selected, "value" => _value},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    aswer = socket.assigns.aswer

    aswer =
      if selection_type == "exclusive" do
        [option_selected]
      else
        [
          option_selected
          | aswer
        ]
      end

    socket =
      socket
      |> assign(:related_question_aswer, aswer)
      |> assign_articles()

    {:noreply, socket}
  end

  def handle_event(
        "related_option_selected",
        %{"option-selected" => option_to_remove},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    aswer = socket.assigns.aswer

    aswer =
      if selection_type == "exclusive" do
        []
      else
        Enum.reject(aswer, fn option_selected ->
          option_selected == option_to_remove
        end)
      end

    socket =
      socket
      |> assign(:related_question_aswer, aswer)
      |> assign_articles()

    {:noreply, socket}
  end

  def handle_event("next_section", _, socket) do
    current_section_index = socket.assigns.current_section_index
    sections = socket.assigns.sections

    new_index =
      if current_section_index + 1 >= length(sections) do
        current_section_index
      else
        current_section_index + 1
      end

    socket =
      socket
      |> assign(:current_section_index, new_index)
      |> assign(:aswer, [])
      |> assign(:is_the_last_one, length(sections) == new_index + 1)

    {:noreply, socket}
  end

  def handle_event("previous_section", _, socket) do
    current_section_index = socket.assigns.current_section_index

    new_index =
      if current_section_index - 1 <= 0 do
        current_section_index
      else
        current_section_index + 1
      end

    socket =
      socket
      |> assign(:current_section_index, new_index)
      |> assign(:aswer, [])
      |> assign(:is_the_last_one, false)

    {:noreply, socket}
  end

  defp assign_articles(socket) do
    articles = socket.assigns.articles
    sections = socket.assigns.sections
    current_section_index = socket.assigns.current_section_index
    aswer = socket.assigns.aswer
    related_question_aswer = socket.assigns.related_question_aswer
    current_section = current_section(sections, current_section_index)

    article_number =
      if length(articles) < current_section_index,
        do: length(articles) + 1,
        else: current_section_index + 1

    new_rule_already_exist =
      !is_nil(Enum.at(articles, current_section_index))

    rule = fill_template(current_section, aswer, related_question_aswer, article_number)

    new_articles =
      if new_rule_already_exist do
        List.replace_at(articles, current_section_index, rule)
      else
        articles ++ [rule]
      end

    socket
    |> assign(:articles, new_articles)
  end

  defp fill_template(current_section, aswer, related_question_aswer, article_number) do
    template = current_section["result_template"]

    case current_section["aswer_type"] do
      "multiple" ->
        template
        |> String.replace("{COOPERATIVE}", "Lawal Cooperativa Tecnologica")
        |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(aswer), ", "))
        |> String.replace("{NUMBER}", to_string(article_number))

      "exclusive" ->
        if aswer == ["SI"] do
          template
          |> String.replace("{NUMBER}", to_string(article_number))
        else
          nil
        end

      "multiple_with_exclusive" ->
        has_related_question_aswer = !Enum.empty?(related_question_aswer)

        template =
          template
          |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(aswer), ", "))
          |> String.replace("{NUMBER}", to_string(article_number))

        if has_related_question_aswer do
          related_question_template = current_section["related_question"]["result_template"]

          template
          |> String.replace("{RELATED_QUESTION}", related_question_template)
        else
          template
          |> String.replace("{RELATED_QUESTION}", "")
        end
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

  defp chapter(sections, index) do
    current_section(sections, index)
    |> Map.fetch!("chapter")
  end

  defp related_question(sections, index) do
    current_section(sections, index)
    |> Map.get("related_question")
  end
end
