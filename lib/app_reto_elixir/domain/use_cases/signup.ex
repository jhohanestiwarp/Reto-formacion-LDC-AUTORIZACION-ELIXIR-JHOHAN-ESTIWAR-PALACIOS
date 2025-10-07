defmodule Reto.Usecase.Signup do
  alias Reto.Domain.Value.{Email, Password}
  alias Reto.Domain.Model.User
  alias Reto.Domain.Error

  def execute(_ctx, email, password, name, repo \\ Reto.Infra.Repo.InMemory.UserRepo) do
    email = Email.new(email)
    _ = Password.new(password)

    case repo.find_by_email(email) do
      {:ok, _u} ->
        Error.raise_const(:email_exists)

      :error ->
        user = %User{id: UUID.uuid4(), email: email, password: password, name: name || ""}
        repo.save(user)
        :ok
    end
  end
end
