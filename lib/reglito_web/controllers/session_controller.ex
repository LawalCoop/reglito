defmodule ReglitoWeb.SessionController do
  use ReglitoWeb, :controller
  import Plug.Conn

  def put_cooperative_info(conn, %{"cooperative_name" => cooperative_name, "registration_number" => registration_number}) do
    conn
    |> put_session(:cooperative_name, cooperative_name)
    |> put_session(:registration_number, registration_number)
    |> redirect(to: "/chapters_selection")
  end

  def put_cooperative_info(conn, _params) do
    conn
    |> send_resp(400, "Invalid parameters")
  end

end
