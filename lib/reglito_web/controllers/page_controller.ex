defmodule ReglitoWeb.PageController do
  use ReglitoWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def info(conn, _params) do
    render(conn, :info)
  end
end
