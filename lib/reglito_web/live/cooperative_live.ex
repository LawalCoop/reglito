defmodule ReglitoWeb.CooperativeLive do
  use ReglitoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="w-full flex flex-col items-center justify-center mt-40">
      <p class="font-bold text-xl mb-10">Completa con los datos de tu Cooperativa</p>
      <div class="w-full max-w-xs">
        <.simple_form for={@form} phx-change="validate" phx-submit="submit_coop">
          <.input field={@form[:name]} label="Nombre de la Cooperativa" />
          <.input field={@form[:registration_number]} label="Matricula" />
          <:actions>
            <button class="aflex justify-center ite bg-blue-500 hover:bg-blue-400 text-white font-bold py-2 px-4 border-b-4 border-blue-700 hover:border-blue-500 rounded">
              Save
            </button>
          </:actions>
        </.simple_form>
      </div>
    </div>
    """
  end

  def mount(_, _session, socket) do
    form =
      to_form(%{"name" => "", "registration_number" => ""})

    socket =
      socket
      |> assign(:form, form)

    {:ok, socket}
  end

  def handle_event(
        "submit_coop",
        %{"name" => name, "registration_number" => registration_number},
        socket
      ) do
    errors = validate(name, registration_number)

    if Enum.empty?(errors) do
      redirect_path =
        "/api/register?cooperative_name=#{name}&registration_number=#{registration_number}"

      {:noreply, push_redirect(socket, to: redirect_path)}
    else
      form =
        to_form(%{"name" => name, "registration_number" => registration_number},
          errors: errors
        )

      {:noreply, assign(socket, :form, form)}
    end
  end

  def handle_event(
        "validate",
        %{"name" => name, "registration_number" => registration_number},
        socket
      ) do
    errors = validate(name, registration_number)

    form =
      to_form(%{"name" => name, "registration_number" => registration_number},
        errors: errors
      )

    {:noreply, assign(socket, :form, form)}
  end

  defp validate(name, registration_number) do
    case {String.length(name) <= 0, String.length(registration_number) <= 0} do
      {true, true} ->
        [name: {"Nombre Requerido", []}, registration_number: {"Matricula Requerida", []}]

      {true, false} ->
        [name: {"Nombre Requerido", []}]

      {false, true} ->
        [registration_number: {"Matricula Requerida", []}]

      {false, false} ->
        []
    end
  end
end
