defmodule Reto.EntryPoints.Plugs.ContextDataPlug do
  import Plug.Conn
  def init(opts), do: opts
  def call(conn, _opts) do
    path = conn.request_path
    if String.starts_with?(path, "/openapi.yaml") do
      conn
    else
      case get_req_header(conn, "message-id") do
        [mid | _] ->
          xid = get_req_header(conn, "x-request-id") |> List.first() || mid
          conn
          |> assign(:message_id, mid)
          |> assign(:x_request_id, xid)
          |> register_before_send(fn c -> put_resp_header(c, "x-request-id", xid) end)
        _ ->
          body = Jason.encode!(%{code: "GEN_001", message: "Solicitud inválida"})
          conn |> put_resp_content_type("application/json") |> send_resp(400, body) |> halt()
      end
    end
  end
end
