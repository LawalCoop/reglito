defmodule ReglitoWeb.SessionController do
  use ReglitoWeb, :controller
  import Plug.Conn

  def modify_session(conn, %{"coop_name" => coop_name, "matricula" => matricula}) do
    conn
    |> put_session(:coop_name, coop_name)
    |> put_session(:matricula, matricula)
    |> redirect(to: "/chapters_selection")
  end

  def modify_session(conn, _params) do
    conn
    |> send_resp(400, "Invalid parameters")
  end

end
