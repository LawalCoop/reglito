defmodule ReglitoWeb.ChapterLiveTest do
  use ReglitoWeb.ConnCase

  import Phoenix.LiveViewTest
  import Reglito.ChaptersFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_chapters(_) do
    # TODO: creatar los features de los chapters
  end

  describe "Index" do
    setup [:create_chapters]
  end
end
