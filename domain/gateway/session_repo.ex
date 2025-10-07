defmodule Reto.Domain.Gateway.SessionRepo do
  @callback create(String.t(), String.t()) :: :ok
end
