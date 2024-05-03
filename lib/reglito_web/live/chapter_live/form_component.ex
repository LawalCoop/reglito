defmodule ReglitoWeb.ChapterLive.FormComponent do
  use ReglitoWeb, :live_component

  alias Reglito.Chapters

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage chapter records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="chapter-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Chapter</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{chapter: chapter} = assigns, socket) do
    changeset = Chapters.change_chapter(chapter)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"chapter" => chapter_params}, socket) do
    changeset =
      socket.assigns.chapter
      |> Chapters.change_chapter(chapter_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"chapter" => chapter_params}, socket) do
    save_chapter(socket, socket.assigns.action, chapter_params)
  end

  defp save_chapter(socket, :edit, chapter_params) do
    case Chapters.update_chapter(socket.assigns.chapter, chapter_params) do
      {:ok, chapter} ->
        notify_parent({:saved, chapter})

        {:noreply,
         socket
         |> put_flash(:info, "Chapter updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_chapter(socket, :new, chapter_params) do
    case Chapters.create_chapter(chapter_params) do
      {:ok, chapter} ->
        notify_parent({:saved, chapter})

        {:noreply,
         socket
         |> put_flash(:info, "Chapter created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
