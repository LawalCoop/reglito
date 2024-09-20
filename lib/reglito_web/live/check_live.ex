defmodule ReglitoWeb.CheckLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="w-full flex flex-col justify-center items-center pt-20">
      <p class="font-bold text-2xl mb-2">
        Gracias por usar este sistema, acá podes modificar los artículos guía
        para que se adapten a tu realidad.
      </p>
      <p class="text-xl">
        Te dejamos además un instructivo que te dice paso a paso como hacer para
        inscribir el reglamento en el INAES.
        <a class="font-bold text-blue-600" href="">Link del Instructivo</a>
      </p>
      <div class="flex flex-col items-center gap-4 w-full h-72 px-20">
        <.simple_form for={@form} phx-change="validate" phx-submit="export">
          <.input
            id="content"
            class="resize rounded-md w-full h-72"
            field={@form[:articles]}
            type="textarea"
          />
          <:actions>
            <div class="w-full flex flex-col justify-center items-center">
              <button class="flex justify-center w-72 gap-2 bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
                Descargar Reglamento <.icon name="hero-arrow-down-tray" />
              </button>
            </div>
          </:actions>
        </.simple_form>
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

    form = to_form(%{"articles" => Enum.join(articles, "\n\n")})

    socket =
      socket
      |> assign(:form, form)

    {:noreply, socket}
  end

  def handle_event("validate", %{"articles" => articles}, socket) do
    errors =
      if String.length(articles) <= 0, do: [articles: {"No puede estar Vacío", []}], else: []

    form =
      to_form(%{"articles" => articles},
        errors: errors
      )

    {:noreply, assign(socket, :form, form)}
  end

  def handle_event("fetch_content", _unsigned_params, socket) do
    {:noreply, push_event(socket, "fetch-content", %{})}
  end

  def handle_event("export", %{"articles" => articles}, socket) do
    articles =
      articles
      |> String.split("\n\n")
      |> Enum.map(fn part -> "<p>#{part}</p>" end)
      |> Enum.join("")

    case ChromicPDF.print_to_pdf({:html, articles}) do
      {:ok, binary} ->
        {:noreply,
         push_event(socket, "pdf-export", %{
           content: binary
         })}
    end
  end
end
