defmodule ReglitoWeb.ChaptersLive do
  use ReglitoWeb, :live_view

  @data [
    %{
      name: "Comida",
      sections: [
        %{
          name: "¿Comemos?",
          options: [
            "Si",
            "No"
          ]
        },
        %{
          name: "¿Que comemos?",
          options: [
            "Asado",
            "Puchero"
          ]
        }
      ]
    },
    %{
      name: "Trabajo",
      sections: [
        %{
          name: "¿Trabajamos?",
          options: [
            "Si",
            "No"
          ]
        },
        %{
          name: "¿De que trabajamos?",
          options: [
            "Programación",
            "Esquilador"
          ]
        }
      ]
    }
  ]

  def render(assigns) do
    ~H"""
    <div>
      <div class="rounded-md flex justify-between px-5 py-3">
        <button class="bg-white rounded-full pl-0.5 pb-0.5" phx-click="previous_chapter">
          <.icon name="hero-chevron-left" class="h-5" />
        </button>
        <p class="font-bold text-2xl">
          <%= @selected_chapter.name %>
        </p>
        <button class="bg-white rounded-full pl-0.5 pb-0.5" phx-click="next_chapter">
          <.icon name="hero-chevron-right" class="h-5" />
        </button>
      </div>

      <div class="bg-black rounded-xl my-2 px-5 py-2 text-white">
        <%= for section <- @selected_chapter.sections do %>
          <div class="flex justify-between items-center my-2">
            <div class="flex items-center">
              <div class="bg-white text-gray-400 rounded-full p-0.5">
                <.icon name="hero-check" />
              </div>
              <p class="pl-5"><%= section.name %></p>
            </div>
            <.icon name="hero-chevron-down" />
          </div>
          <%= for option <- section.options do %>
            <div class="flex flex-col gap-2 items-center my-3">
              <div class="flex bg-white w-full text-black rounded-xl pr-5 py-2">
                <div class="mx-2">
                  <div class="bg-gray-200 rounded-full text-gray-400">
                    <.icon name="hero-check" />
                  </div>
                </div>
                <p>
                  <%= option %>
                </p>
              </div>
            </div>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    selected_chapter_index = 0
    selected_chapter = Enum.at(@data, selected_chapter_index)

    socket =
      socket
      |> assign(:selected_chapter_index, selected_chapter_index)
      |> assign(:selected_chapter, selected_chapter)

    {:ok, socket}
  end

  def handle_event("next_chapter", _, socket) do
    current_selected_chapter_index = socket.assigns.selected_chapter_index
    chapter_quantity = length(@data) - 1
    new_selected_chapter_index = current_selected_chapter_index + 1

    new_selected_chapter_index =
      if new_selected_chapter_index > chapter_quantity do
        0
      else
        new_selected_chapter_index
      end

    socket =
      socket
      |> assign(:selected_chapter_index, new_selected_chapter_index)
      |> assign(:selected_chapter, Enum.at(@data, new_selected_chapter_index))

    {:noreply, socket}
  end

  def handle_event("previous_chapter", _, socket) do
    current_selected_chapter_index = socket.assigns.selected_chapter_index
    chapter_quantity = length(@data) - 1
    new_selected_chapter_index = current_selected_chapter_index - 1

    new_selected_chapter_index =
      if new_selected_chapter_index < 0 do
        chapter_quantity
      else
        new_selected_chapter_index
      end

    socket =
      socket
      |> assign(:selected_chapter_index, new_selected_chapter_index)
      |> assign(:selected_chapter, Enum.at(@data, new_selected_chapter_index))

    {:noreply, socket}
  end
end
