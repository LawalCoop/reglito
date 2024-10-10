defmodule ReglitoWeb.Start.Components.QuestionViewer do
  use Phoenix.Component

  import ReglitoWeb.Start.Helpers
  import ReglitoWeb.CoreComponents

  def question_viewer(assigns) do
    ~H"""
    <div class="flex flex-col w-full items-start pt-16">
      <p class="font-bold text-2xl mb-5">
        <%= question(@sections, @current_section_index) %>
      </p>
      <div>
        <%= case aswer_type(@sections, @current_section_index) do %>
          <% "refillable" -> %>
            <.simple_form for={@refillable_form} phx-change="form_changed">
              <%= for {option, i} <- Enum.with_index(options(@sections, @current_section_index)) do %>
                <p>
                  <.input
                    type="text"
                    label={option}
                    id={option}
                    field={@refillable_form["option_#{i}"]}
                  />
                </p>
              <% end %>
            </.simple_form>
          <% _ -> %>
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

      <div class="w-full flex justify-between mt-5">
        <button
          phx-click="previous_section"
          class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
        >
          <.icon name="hero-chevron-left" /> Volver
        </button>
        <%= if @is_the_last_one do %>
          <button
            phx-click="to_check"
            class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
          >
            Revisar <.icon name="hero-chevron-right" />
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
    """
  end
end
