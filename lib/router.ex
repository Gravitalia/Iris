defmodule Iris.Router do
  use Plug.Router
  require EEx

  plug Plug.Static,
    at: "/",
    from: :iris
  plug :match
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  plug :dispatch

  match _ do
    send_resp(conn, 404, "404")
  end
end
