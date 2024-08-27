defmodule ReglitoWeb.StartLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex h-full w-full">
      <!-- Primera mitad -->
      <div class="w-1/2 h-full overflow-y-scroll">
        <div class="p-4">
          <!-- Contenido largo para permitir scroll -->
          <p>Contenido largo en la primera mitad...</p>
          <!-- Añade más contenido aquí -->
        </div>
      </div>
      <!-- Segunda mitad -->
      <div class="w-1/2 h-full overflow-y-scroll">
        <div class="p-4">
          <!-- Contenido largo para permitir scroll -->
          <p>Contenido largo en la segunda mitad...</p>
          <!-- Añade más contenido aquí -->
        </div>
      </div>
    </div>
    """
  end
end
