defmodule ReglitoWeb.StartLive do
  use ReglitoWeb, :live_view

  alias Reglito.Chapters

  import ReglitoWeb.Start.Helpers
  import ReglitoWeb.Start.Components.Header
  import ReglitoWeb.Start.Components.QuestionViewer
  import ReglitoWeb.Start.Components.ArticlesViewer

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full w-full">
      <.page_info
        sections={@sections}
        current_section_index={@current_section_index}
        progress_multiplier={@progress_multiplier}
      />

      <div class="flex">
        <div class="w-1/2 h-full flex pl-20">
          <.question_viewer
            sections={@sections}
            current_section_index={@current_section_index}
            is_the_last_one={@is_the_last_one}
            aswer={@aswer}
          />
        </div>
        <div class="w-1/2 h-full overflow-y-scroll m-5 p-5 bg-gray-100 rounded-xl">
          <.articles_viewer articles={@articles} />
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"selected_chapters" => selected_chapters}, _session, socket) do
    chapters = Chapters.read_chapters_data()

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
    aswer = socket.assigns.related_question_aswer

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
      if aswer_type(sections, new_index) == "refillable",
        do: assign(socket, :refillable_form, to_form(%{"option_1" => ""})),
        else: socket

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

  def handle_event("to_check", _, socket) do
    {:noreply,
     push_navigate(socket,
       to: "/check?articles=#{Base.encode64(Jason.encode!(socket.assigns.articles))}"
     )}
  end

  def handle_event("form_changed", params, socket) do
    aswer =
      params
      |> Map.delete("_target")
      |> Map.values()

    socket =
      socket
      |> assign(:aswer, aswer)
      |> assign_articles()

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
        has_related_question_aswer =
          !Enum.empty?(related_question_aswer) && related_question_aswer != "NO"

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

      "refillable" ->
        Enum.reduce(aswer, template, fn a, acc ->
          String.replace(acc, "{ASWER}", a, global: false)
        end)
        |> String.replace("{NUMBER}", to_string(article_number))
    end
  end
end
