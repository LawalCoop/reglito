defmodule ReglitoWeb.Start.Components.ArticlesViewer do
  use Phoenix.Component

  def articles_viewer(assigns) do
    ~H"""
    <div class="w-full flex flex-col justify-center">
      <%= for {article, i} <- Enum.with_index(@articles) do %>
        <p id={"#{i}"}><%= article %></p>
      <% end %>
    </div>
    """
  end
end
