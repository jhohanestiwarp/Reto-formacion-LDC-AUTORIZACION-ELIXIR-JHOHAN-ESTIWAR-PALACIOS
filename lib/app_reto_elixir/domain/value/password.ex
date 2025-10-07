defmodule Reto.Domain.Value.Password do
  alias Reto.Domain.Error
  def new(nil), do: Error.raise_const(:weak_password)
  def new(value) when is_binary(value) and byte_size(value) >= 8, do: value
  def new(_), do: Error.raise_const(:weak_password)
end
