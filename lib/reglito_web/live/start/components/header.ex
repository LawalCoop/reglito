defmodule ReglitoWeb.Start.Components.Header do
  use Phoenix.Component

  alias Reglito.Chapters

  import ReglitoWeb.Start.Helpers

  def page_info(assigns) do
    ~H"""
    <div class="px-20">
      <div class="p-4">
        <p class="">Reglamento interno de:</p>
        <p class="text-xl font-bold">Lawal Cooperativa Tecnologica Ltda.</p>
      </div>
      <p class="font-bold mb-2">
        Capitulo: <%= Chapters.chapter_name_by_code()[chapter(@sections, @current_section_index)] %>
      </p>
      <div class="w-full bg-gray-200 rounded-full h-2.5 dark:bg-gray-300">
        <div
          class="bg-blue-600 h-2.5 rounded-full"
          style={"width: #{progress_multiplier(@sections)  * (@current_section_index + 1)}%"}
        >
        </div>
      </div>
    </div>
    """
  end

  defp progress_multiplier(sections) do
    100 / length(sections)
  end
end
