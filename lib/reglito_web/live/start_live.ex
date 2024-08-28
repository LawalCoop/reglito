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
              <%= Enum.at(@chapters_info["COOPERATIVE"]["sections"], 0)["question"] %>
            </p>
            <div>
              <%= for option <- Enum.at(@chapters_info["COOPERATIVE"]["sections"], 0)["options"] do %>
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
              <button class="bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
                <.icon name="hero-chevron-left" /> Volver
              </button>
              <button class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
                Siguiente <.icon name="hero-chevron-right" />
              </button>
            </div>
          </div>
        </div>
        <div class="w-1/2 h-full overflow-y-scroll m-5 p-5 bg-gray-100 rounded-xl">
          <div class="w-full flex justify-center">
            <div class="s">
              <p>
                <%= render_template(
                  Enum.at(@chapters_info["COOPERATIVE"]["sections"], 0)["result_template"],
                  @options_selected
                ) %>
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(%{"selected_chapters" => selected_chapters}, _session, socket) do
    # TODO: mover el fetch de la info a su propio modulo
    chapters_info =
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

    socket =
      socket
      |> assign(:selected_chapters, selected_chapters)
      |> assign(:chapters_info, chapters_info)
      |> assign(:options_selected, [])

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

    {:noreply, socket}
  end

  defp render_template(template, options) do
    template
    |> String.replace("{COOPERATIVE}", "Lawal Cooperativa Tecnologica")
    |> String.replace("{OPTIONS}", Enum.join(options, ", "))
    |> String.replace("{NUMBER}", "1")
  end
end
