defmodule ReglitoWeb.Start.Components.QuestionViewer do
  use Phoenix.LiveComponent

  import ReglitoWeb.Start.Helpers
  import ReglitoWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <div class="flex flex-col w-full pt-10">
      <.question sections={@sections} current_section_index={@current_section_index} />
      <.user_inputs
        sections={@sections}
        current_section_index={@current_section_index}
        answers={@answers}
        target={@myself}
        form={@form}
      />
      <.buttons is_the_last_one={@is_the_last_one} target={@myself} />
    </div>
    """
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(:sections, assigns.sections)
      |> assign(:current_section_index, 0)
      |> assign(:is_the_last_one, false)
      |> assign(:answers, [])
      |> assign(:form, to_form(%{}))

    {:ok, socket}
  end

  def handle_event("next_section", _params, socket) do
    current_section_index = socket.assigns.current_section_index
    sections_quantity = length(socket.assigns.sections)

    new_index =
      if current_section_index + 1 >= sections_quantity do
        current_section_index
      else
        current_section_index + 1
      end

    socket =
      socket
      |> assign(:current_section_index, new_index)

    {:noreply, socket}
  end

  def handle_event("previous_section", _params, socket) do
    current_section_index = socket.assigns.current_section_index

    new_index =
      if current_section_index - 1 < 0 do
        current_section_index
      else
        current_section_index - 1
      end

    socket =
      socket
      |> assign(:current_section_index, new_index)

    {:noreply, socket}
  end

  def handle_event("to_check", _, socket) do
    {:noreply,
     push_navigate(socket,
       to: "/check?articles=#{Base.encode64(Jason.encode!(socket.assigns.articles))}"
     )}
  end

  def handle_event("user_aswer_check_box", params, socket) do
    answers = socket.assigns.answers

    current_section_index =
      socket.assigns.current_section_index

    current_section = current_section(socket.assigns.sections, current_section_index)

    user_input =
      params
      |> Map.delete("_target")
      |> Enum.filter(fn {_key, value} -> value == "true" end)
      |> Enum.map(fn {key, _value} -> key end)

    answers_updated =
      if Enum.empty?(user_input) do
        List.delete_at(answers, current_section_index)
      else
        update_or_insert(answers, current_section_index, %{
          answer: user_input,
          answer_type: current_section["aswer_type"],
          template: current_section["result_template"]
        })
      end

    send(self(), {:awsers_updated, %{answers_updated: answers_updated}})

    {:noreply, assign(socket, :answers, answers_updated)}
  end

  #
  # COMPONENTS
  #

  defp question(assigns) do
    ~H"""
    <p class="font-bold text-2xl mb-5">
      <%= question(@sections, @current_section_index) %>
    </p>
    """
  end

  defp user_inputs(assigns) do
    ~H"""
    <div>
      <div>
        <%= case aswer_type(@sections, @current_section_index) do %>
          <% "refillable" -> %>
            <.simple_form for={@form} phx-change="user_aswer_form" target={@target}>
              <%= for {option, i} <- Enum.with_index(options(@sections, @current_section_index)) do %>
                <p>
                  <.input type="text" label={option} id={option} field={@form["option_#{i}"]} />
                </p>
              <% end %>
            </.simple_form>
          <% _ -> %>
            <.simple_form for={@form} phx-change="user_aswer_check_box" phx-target={@target}>
              <%= for option <- options(@sections, @current_section_index) do %>
                <p>
                  <.input id={option} name={option} type="checkbox" label={option} />
                </p>
              <% end %>
            </.simple_form>
        <% end %>
      </div>
      <.related_question sections={@sections} current_section_index={@current_section_index} />
    </div>
    """
  end

  defp related_question(assigns) do
    ~H"""
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
                  Enum.any?(@related_question_aswer, fn selected_option ->
                    selected_option == option
                  end)
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
    """
  end

  defp buttons(assigns) do
    ~H"""
    <div class="w-full flex justify-between mt-5">
      <button
        phx-target={@target}
        phx-click="previous_section"
        class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
      >
        <.icon name="hero-chevron-left" /> Volver
      </button>
      <%= if @is_the_last_one do %>
        <button
          phx-target={@target}
          phx-click="to_check"
          class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
        >
          Revisar <.icon name="hero-chevron-right" />
        </button>
      <% else %>
        <button
          phx-target={@target}
          phx-click="next_section"
          class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
        >
          Siguiente <.icon name="hero-chevron-right" />
        </button>
      <% end %>
    </div>
    """
  end

  #
  # HELPERS
  #
  def update_or_insert(list, index, value) when is_list(list) and is_integer(index) do
    list_length = length(list)

    cond do
      index < list_length ->
        List.replace_at(list, index, value)

      index >= list_length ->
        list ++ List.duplicate(nil, index - list_length) ++ [value]
    end
  end
end
