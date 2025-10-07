defmodule Reto.Usecase.Signin do
  alias Reto.Domain.Error
  def execute(_ctx, email, password,
              user_repo \\ Reto.Infra.Repo.InMemory.UserRepo,
              sess_repo \\ Reto.Infra.Repo.InMemory.SessionRepo) do
    case user_repo.find_by_email(String.downcase(email || "")) do
      {:ok, user} ->
        if user.password == password do
          sid = UUID.uuid4()
          sess_repo.create(sid, user.id)
          {:ok, sid}
        else
          Error.raise_const(:invalid_credentials)
        end
      :error -> Error.raise_const(:user_not_found)
    end
  end
end
