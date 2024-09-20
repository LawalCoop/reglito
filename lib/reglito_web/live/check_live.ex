defmodule ReglitoWeb.CheckLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="w-full flex flex-col justify-center items-center pt-40">
      <p class="font-bold text-2xl mb-2">
        Gracias por usar este sistema, acá podes modificar los artículos guía
        para que se adapten a tu realidad.
      </p>
      <p class="text-xl">
        Te dejamos además un instructivo que te dice paso a paso como hacer para
        inscribir el reglamento en el INAES.
        <a class="font-bold text-blue-600" href="">Link del Instructivo</a>
      </p>
      <div class="flex flex-col items-center gap-4 w-full px-20">
        <.simple_form for={@form} phx-change="validate" phx-submit="save">
          <.input
            class="resize rounded-md w-full"
            field={@form[:articles]}
            value={@articles}
            type="textarea"
          />
        </.simple_form>
        <button
          id="export"
          phx-hook="Export"
          class="w-64 gap-4 bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded flex justify-center items-center"
        >
          Descargar Reglamento <.icon name="hero-arrow-down-tray" />
        </button>
      </div>
    </div>
    """
  end

  def mount(_, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"articles" => articles}, _uri, socket) do
    articles =
      articles
      |> Base.decode64!()
      |> Jason.decode!()

    form = to_form(%{articles: ""})

    socket =
      socket
      |> assign(:articles, Enum.join(articles, "\n\n"))
      |> assign(:form, form)

    {:noreply, socket}
  end

  def handle_event("fetch_content", _unsigned_params, socket) do
    {:noreply, push_event(socket, "fetch-content", %{})}
  end

  def handle_event("send_html_to_backend", %{"html" => _html}, socket) do
    html =
      "<html><meta charset='UTF-8'><body><p>Hi ARTÍCULO!</p></body></html>"

    case ChromicPDF.print_to_pdf({:html, html}) do
      {:ok, binary} ->
        {:noreply,
         push_event(socket, "pdf-export", %{
           content: binary
         })}
    end
  end
end
