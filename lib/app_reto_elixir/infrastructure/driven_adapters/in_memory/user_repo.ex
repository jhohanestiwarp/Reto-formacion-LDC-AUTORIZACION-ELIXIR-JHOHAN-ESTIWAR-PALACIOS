defmodule Reto.Infra.Repo.InMemory.UserRepo do
  @behaviour Reto.Domain.Gateway.UserRepo
  alias Reto.Domain.Model.User
  @table :users_by_email

  def find_by_email(email) when is_binary(email) do
    case :ets.lookup(@table, email) do
      [{^email, user}] -> {:ok, user}
      [] -> :error
    end
  end

  def save(%User{} = user) do
    true = :ets.insert(@table, {user.email, user})
    :ok
  end
end
