defmodule Reto.Domain.Model.User do
  @enforce_keys [:id, :email, :password, :name]
  defstruct [:id, :email, :password, :name]
end
