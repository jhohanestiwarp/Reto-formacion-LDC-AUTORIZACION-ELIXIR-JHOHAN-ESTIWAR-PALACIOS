defmodule Reto.Domain.Value.Email do
  alias Reto.Domain.Error
  @regex ~r/^[^@\n]+@[^@\n]+\.[^@\n]+$/
  def new(nil), do: Error.raise_const(:invalid_email_format)

  def new(value) when is_binary(value),
    do:
      if(Regex.match?(@regex, value),
        do: String.downcase(value),
        else: Error.raise_const(:invalid_email_format)
      )

  def new(_), do: Error.raise_const(:invalid_email_format)
end
