defmodule ReglitoWeb.CheckLive do
  use ReglitoWeb, :live_view

  @content """
  ARTÍCULO 1: La Cooperativa de trabajo Lawal Cooperativa Tecnologica Ltda. desarrollará sus actividades de acuerdo a Ley 20.337, Estatuto social, Presente reglamento, Normas y principios cooperativos, Principios de la ACI, Principios CICOPA.

          ARTICULO 2: El consejo de administración procurará el crecimiento de la entidad, sobre la base de alentar y promover el espíritu de trabajo mancomunado, el respeto común y la convivencia solidaria entre las personas asociadas, con el fin de crear el medio ideal que permita alcanzar la máxima productividad, la ocupación continua de las personas asociadas, el mantenimiento de la mejor relación con quienes contraten o se relacionen con la cooperativa, la constante educación y capacitación de las personas asociadas. Este reglamento establecerá la manera de organización y funcionamiento de la cooperativa y establecerá la forma de disciplina y control requerido para ésta.

          ARTICULO 3: Las personas integrantes del Consejo de Administración y la sindicatura deberán ser elegidos en Asambleas General, Ordinaria o Extraordinaria por voto de las personas asociadas presentes por mayoría simple, que de acuerdo al Estatuto Social y a la Ley 20.337 o a la que la modifique y este reglamento estén en condiciones de hacerlo. Para ser candidato/a a consejero/a o síndico/a de la cooperativa la personas asociada deberá ser mayor de 18 años de edad. El consejo deberá reunirse como mínimo una vez al mes y podrá reunirse en cualquier momento que la circunstancia lo exija.

          ARTICULO 4: La gestión económica y contable dependerá del consejo de Administración, que lo hace a través de la estructura de la Cooperativa sin embargo todas las personas asociadas deberán prestar su colaboración en caso de ser requerida. En el desarrollo de las actividades se deberá cumplir con las disposiciones legales, estatutarias y las resoluciones de asambleas.

          ARTICULO 5: Las personas asociadas autorizan a la cooperativa a utilizar sus imágenes, ya sea en fotografías, vídeos u otros medios audiovisuales, en el marco de las actividades promocionales, publicitarias y de difusión de la Cooperativa sin necesidad de que se genere ningún tipo de derecho a percibir contraprestación económica alguna por parte de las personas asociadas.

          ARTICULO 6: La cooperativa se distribuirá en las siguientes áreas, Producción, Administración, Control de calidad. Cada una de ellas tendrá un/a coordinador/a designado/a por el Consejo de Administración por el tiempo que este determine. El Consejo podrá a su vez, modificar las áreas de la cooperativa así como todo el articulado de esta sección sin necesidad de reforma del reglamento toda vez que son cuestiones de mera organización interna.
  """

  def render(assigns) do
    ~H"""
    <div class="w-full flex justify-center items-center pt-40">
      <div class="flex flex-col items-center gap-4 w-full h-96 px-20">
        <textarea id="content" class="resize rounded-md w-full h-full">
          <%= @content %>
        </textarea>
        <button
          phx-click="export"
          class="w-52 bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded flex justify-center items-center"
        >
          Exportar Archivo <.icon name="hero-arrow-down-tray" />
        </button>
      </div>
    </div>
    """
  end

  def mount(_, _session, socket) do
    {:ok, assign(socket, :content, @content)}
  end

  def handle_event("export", _unsigned_params, socket) do
    case PdfGenerator.generate_binary(socket.assigns.content, page_size: "A4") do
      {:ok, binary} ->
        {:noreply,
         socket
         |> push_event("pdf-export", %{content: Base.encode64(binary)})}

      {:error, reason} ->
        {:noreply,
         socket
         |> put_flash(:error, "Failed to generate PDF: #{reason}")}
    end

    {:noreply, socket}
  end
end