defmodule HelloNerves.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "Hello from Nerves!")
  end

  get "/blink/:ms" do
    HelloNerves.Store.put(:blink_ms, String.to_integer(ms))
    send_resp(conn, 200, "Set blink duration: #{ms}ms")
  end

    match _ do
    send_resp(conn, 404, "Oops!")
  end
end
