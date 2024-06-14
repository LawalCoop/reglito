defmodule ReglitoWeb.ChaptersLive do
  use ReglitoWeb, :live_view

  @data [
    %{
      name: "Comida",
      sections: [
        %{
          id: 1,
          name: "¿Comemos?",
          options: [
            "Si",
            "No"
          ]
        },
        %{
          id: 2,
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
          id: 3,
          name: "¿Trabajamos?",
          options: [
            "Si",
            "No"
          ]
        },
        %{
          id: 4,
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

      <%= for {section, section_index} <- @selected_chapter.sections do %>
        <div class="bg-black rounded-xl my-2 px-5 py-2 text-white">
          <div
            class="flex justify-between items-center my-2 cursor-pointer"
            phx-click="open_section"
            phx-value-section-id={section.id}
          >
            <div class="flex items-center">
              <p class="pl-5"><%= section.name %></p>
            </div>
            <%= if Map.get(@section_is_open_by_id, section.id, false) do %>
              <.icon name="hero-chevron-up" />
            <% else %>
              <.icon name="hero-chevron-down" />
            <% end %>
          </div>

          <%= if Map.get(@section_is_open_by_id, section.id, false) do %>
            <%= for {option, index, is_selected} <- section.options do %>
              <div class="flex flex-col gap-2 items-center my-3">
                <div
                  class="flex bg-white w-full text-black rounded-xl pr-5 py-2 cursor-pointer"
                  phx-click="option_selected"
                  phx-value-option-index={index}
                  phx-value-section-index={section_index}
                >
                  <div class="mx-2">
                    <div class={" #{if is_selected do "bg-green-600" else"bg-gray-200"end} rounded-full #{if is_selected do "text-white" else"text-gray-400"end}"}>
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
      <% end %>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    selected_chapter_index = 0

    selected_chapter =
      @data
      |> Enum.at(selected_chapter_index)
      |> Map.update!(:sections, fn sections ->
        Enum.map(sections, fn section ->
          Map.update!(section, :options, fn options ->
            options
            |> Enum.with_index()
            |> Enum.map(fn {option, index} -> {option, index, false} end)
          end)
        end)
        |> Enum.with_index()
      end)

    socket =
      socket
      |> assign(:section_is_open_by_id, %{})
      |> assign(:selected_chapter_index, selected_chapter_index)
      |> assign(:selected_chapter, selected_chapter)
      |> assign(:selected_options_by_section_id, %{})

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

    a =
      @data
      |> Enum.at(new_selected_chapter_index)
      |> Map.update!(:sections, fn sections ->
        Enum.map(sections, fn section ->
          Map.update!(section, :options, fn options ->
            options
            |> Enum.with_index()
            |> Enum.map(fn {option, index} -> {option, index, false} end)
          end)
        end)
        |> Enum.with_index()
      end)

    IO.inspect(a, label: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")

    socket =
      socket
      |> assign(:selected_chapter_index, new_selected_chapter_index)
      |> assign(:selected_chapter, a)

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

  def handle_event("open_section", %{"section-id" => section_id}, socket) do
    section_id = String.to_integer(section_id)
    section_is_open_by_id = socket.assigns.section_is_open_by_id
    is_selected = not Map.get(section_is_open_by_id, section_id, false)

    section_is_open_by_id =
      Map.merge(section_is_open_by_id, %{section_id => is_selected})

    IO.inspect(section_is_open_by_id)

    {:noreply,
     assign(
       socket,
       :section_is_open_by_id,
       section_is_open_by_id
     )}
  end

  def handle_event(
        "option_selected",
        %{
          "option-index" => option_index,
          "section-index" => section_index
        },
        socket
      ) do
    section_index = String.to_integer(section_index)
    option_index = String.to_integer(option_index)
    selected_chapter = socket.assigns.selected_chapter

    sections = selected_chapter.sections
    {section, s_i} = Enum.at(sections, section_index)

    options = section.options
    {option, o_i, is_selected} = Enum.at(options, option_index)

    new_options = List.replace_at(options, option_index, {option, o_i, !is_selected})

    new_sections =
      List.replace_at(
        sections,
        section_index,
        {Map.update!(section, :options, fn _ -> new_options end), s_i}
      )

    selected_chapter = Map.update!(selected_chapter, :sections, fn _ -> new_sections end)

    IO.inspect(selected_chapter, label: "selected_chapter")

    socket =
      socket
      |> assign(:selected_chapter, selected_chapter)

    {:noreply, socket}
  end
end
