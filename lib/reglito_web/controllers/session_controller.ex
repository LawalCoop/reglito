defmodule ReglitoWeb.SessionController do
  use ReglitoWeb, :controller
  import Plug.Conn

  def modify_session(conn, %{"coop_name" => coop_name, "matricula" => matricula}) do
    IO.inspect(coop_name, label: "name")

    conn
    |> put_session(:coop_name, coop_name)
    |> put_session(:matricula, matricula)
    |> send_resp(201, "Success")
  end

  # Handle other cases, such as missing parameters
  def modify_session(conn, _params) do
    conn
    |> send_resp(400, "Invalid parameters")
  end

end
