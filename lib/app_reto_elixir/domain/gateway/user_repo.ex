defmodule Reto.Domain.Gateway.UserRepo do
  @callback find_by_email(String.t()) :: {:ok, Reto.Domain.Model.User.t()} | :error
  @callback save(Reto.Domain.Model.User.t()) :: :ok
end
