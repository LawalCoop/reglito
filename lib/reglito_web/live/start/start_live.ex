defmodule ReglitoWeb.StartLive do
  use ReglitoWeb, :live_view

  alias Reglito.Chapters
  alias ReglitoWeb.Start.Components.QuestionViewer

  import ReglitoWeb.Start.Helpers
  import ReglitoWeb.Start.Components.Header
  import ReglitoWeb.Start.Components.ArticlesViewer

  def render(assigns) do
    ~H"""
    <div class="flex flex-col h-full w-full">
      <.page_info sections={@sections} current_section_index={0} />

      <div class="flex">
        <div class="w-1/2 h-full flex pl-20">
          <.live_component module={QuestionViewer} id="question_viewer" sections={@sections} />
        </div>
        <div class="w-1/2 h-full overflow-y-scroll m-5 p-5 bg-gray-100 rounded-xl">
          <.articles_viewer articles={@articles} />
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"selected_chapters" => selected_chapters}, _session, socket) do
    sections =
      selected_chapters
      |> Chapters.selected_chapters_data()
      |> Chapters.all_sections()

    socket =
      socket
      |> assign(:sections, sections)
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
    current_aswer = socket.assigns.aswer

    new_aswer =
      if selection_type == "exclusive" do
        [option_selected]
      else
        [
          option_selected
          | current_aswer
        ]
      end

    socket =
      socket
      |> assign(:current_aswer, new_aswer)

    {:noreply, socket}
  end

  def handle_event(
        "option_selected",
        %{"option-selected" => option_to_remove},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    current_aswer = socket.assigns.current_aswer

    new_aswer =
      if selection_type == "exclusive" do
        []
      else
        Enum.reject(current_aswer, fn option_selected ->
          option_selected == option_to_remove
        end)
      end

    socket =
      socket
      |> assign(:current_aswer, new_aswer)

    {:noreply, socket}
  end

  def handle_event(
        "related_option_selected",
        %{"option-selected" => option_selected, "value" => _value},
        socket
      ) do
    selection_type = aswer_type(socket.assigns.sections, socket.assigns.current_section_index)
    current_aswer = socket.assigns.current_aswer

    new_aswer =
      if selection_type == "exclusive" do
        [option_selected]
      else
        [
          option_selected
          | current_aswer
        ]
      end

    socket =
      socket
      |> assign(:related_question_aswer, new_aswer)

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

    {:noreply, socket}
  end

  def handle_event("form_changed", params, socket) do
    aswer =
      params
      |> Map.delete("_target")
      |> Map.values()

    socket =
      socket
      |> assign(:aswer, aswer)

    {:noreply, socket}
  end

  def handle_info({:awsers_updated, %{answers_updated: answers_updated}}, socket) do
    socket =
      socket
      |> assign(:articles, generate_articles(answers_updated))

    {:noreply, socket}
  end

  defp generate_articles(aswers) do
    aswers
    |> Enum.filter(fn answer -> !is_nil(answer) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {user_input, article_number} ->
      case user_input.answer_type do
        "multiple" ->
          if Enum.empty?(user_input.answer) do
            nil
          else
            user_input.template
            # TODO: usar la información que nos dió el usuario
            |> String.replace("{COOPERATIVE}", "Lawal Cooperativa Tecnologica")
            |> String.replace("{OPTIONS}", Enum.join(user_input.answer, ", "))
            |> String.replace("{NUMBER}", to_string(article_number))
          end

        "exclusive" ->
          if user_input.aswer == ["SI"] do
            user_input.template
            |> String.replace("{NUMBER}", to_string(article_number))
          else
            nil
          end

        # "multiple_with_exclusive" ->
        #   has_related_question_aswer =
        #     !Enum.empty?(related_question_aswer) && related_question_aswer != "NO"

        #   template =
        #     user_input.template
        #     |> String.replace("{OPTIONS}", Enum.join(Enum.reverse(user_input.aswer), ", "))
        #     |> String.replace("{NUMBER}", to_string(article_number))

        #   if has_related_question_aswer do
        #     related_question_template = current_section["related_question"]["result_template"]

        #     template
        #     |> String.replace("{RELATED_QUESTION}", related_question_template)
        #   else
        #     template
        #     |> String.replace("{RELATED_QUESTION}", "")
        #   end

        "refillable" ->
          Enum.reduce(user_input.aswer, user_input.template, fn a, acc ->
            String.replace(acc, "{ASWER}", a, global: false)
          end)
          |> String.replace("{NUMBER}", to_string(article_number))
      end
    end)
  end
end
