defmodule AppRetoElixir.Infrastructure.EntryPoints.Router do
  use Plug.Router
  import Plug.Conn

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Jason
  plug :match
  plug :dispatch

  post "/signup" do
    with %{"email" => email, "password" => password} <- conn.body_params do
      :ok =
        AppRetoElixir.Domain.UseCases.Signup.execute(
          %{message_id: conn.assigns[:message_id], x_request_id: conn.assigns[:x_request_id]},
          email,
          password,
          Map.get(conn.body_params, "name")
        )

      send_resp(conn, 201, "")
    else
      _ ->
        body = Jason.encode!(%{code: "GEN_001", message: "Solicitud inválida"})
        send_resp(put_resp_content_type(conn, "application/json"), 400, body)
    end
  end

  post "/signin" do
    with %{"email" => email, "password" => password} <- conn.body_params,
         {:ok, sid} <-
           AppRetoElixir.Domain.UseCases.Signin.execute(
             %{message_id: conn.assigns[:message_id], x_request_id: conn.assigns[:x_request_id]},
             email,
             password
           ) do
      body = Jason.encode!(%{session_id: sid})
      send_resp(put_resp_content_type(conn, "application/json"), 200, body)
    else
      _ ->
        body = Jason.encode!(%{code: "GEN_001", message: "Solicitud inválida"})
        send_resp(put_resp_content_type(conn, "application/json"), 400, body)
    end
  end

  get "/ping" do
    send_resp(conn, 200, Jason.encode!(%{status: "ok"}))
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
