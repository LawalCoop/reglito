defmodule ReglitoWeb.CooperativeLive do
  use ReglitoWeb, :live_view

  # TODO: Setear la informacion de la cooperativa en la session

  def render(assigns) do
    ~H"""
    <div class="w-full flex flex-col items-center justify-center mt-40">
      <p class="font-bold text-xl mb-10">Completa con los datos de tu Cooperativa</p>
      <div class="w-full max-w-xs">
        <form phx-submit="submit_coop" class="bg-white shadow-xl rounded px-8 pt-6 pb-8 mb-4">
          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-bold mb-2" for="coop_name">
              Nombre de la Cooperativa
            </label>
            <input
              class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="coop_name"
              name="coop_name"
              type="text"
              placeholder="Nombre de la Cooperativa"
              phx-hook="Form"
            />
          </div>
          <div class="mb-4">
            <label class="block text-gray-700 text-sm font-bold mb-2" for="matricula">
              Matrícula
            </label>
            <input
              class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
              id="matricula"
              name="matricula"
              type="text"
              placeholder="Matrícula"
              phx-hook="Form"
            />
          </div>
          <div class="flex items-center justify-center">
            <button
              type="submit"
              class="flex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded"
            >
              Siguiente
            </button>
          </div>
        </form>
      </div>
    </div>
    """
  end

  def handle_event("submit_coop", %{"coop_name" => coop_name, "matricula" => matricula}, socket) do

    socket = assign(socket, coop_name: coop_name, matricula: matricula)
    {:noreply, push_redirect(socket, to: "/chapters_selection?coop_name=#{coop_name}&matricula=#{matricula}")}
  end
end
