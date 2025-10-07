defmodule Reto.Infra.Repo.InMemory.SessionRepo do
  @behaviour Reto.Domain.Gateway.SessionRepo
  @table :sessions
  def create(session_id, user_id),
    do:
      (
        true = :ets.insert(@table, {session_id, user_id})
        :ok
      )
end
