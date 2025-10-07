defmodule Reto.EntryPoints.ErrorHandler do
  import Plug.Conn
  alias Reto.Domain.Error
  alias Reto.Domain.Error.BusinessException

  def init(opts), do: opts
  def call(conn, _opts), do: conn

  use Plug.ErrorHandler

  def handle_errors(conn, %{reason: %BusinessException{} = ex}) do
    body = Jason.encode!(%{code: ex.code, message: ex.message})
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(ex.status, body)
  end

  def handle_errors(conn, _assigns) do
    c = Error.constants().unexpected_error
    body = Jason.encode!(%{code: c.code, message: c.message})
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(c.status, body)
  end
end
