defmodule Reto.Domain.Error do
  defmodule BusinessException do
    defexception [:status, :code, :message, :internal, :log_code]
  end

  def constants do
    %{
      invalid_email_format: %{
        status: 400,
        code: "AUTH_001",
        message: "Formato de email inválido",
        internal: "Email no cumple patrón",
        log_code: "ECS-AUTH-001"
      },
      weak_password: %{
        status: 400,
        code: "AUTH_002",
        message: "Contraseña demasiado corta",
        internal: "Longitud mínima 8",
        log_code: "ECS-AUTH-002"
      },
      email_exists: %{
        status: 409,
        code: "AUTH_003",
        message: "El email ya existe",
        internal: "Índice UNIQUE de email",
        log_code: "ECS-AUTH-003"
      },
      user_not_found: %{
        status: 404,
        code: "AUTH_004",
        message: "Usuario no encontrado",
        internal: "No existe usuario con email",
        log_code: "ECS-AUTH-004"
      },
      invalid_credentials: %{
        status: 401,
        code: "AUTH_005",
        message: "Credenciales inválidas",
        internal: "Password no coincide",
        log_code: "ECS-AUTH-005"
      },
      malformed_request: %{
        status: 400,
        code: "GEN_001",
        message: "Solicitud inválida",
        internal: "Body/headers inválidos",
        log_code: "ECS-GEN-001"
      },
      unexpected_error: %{
        status: 500,
        code: "GEN_999",
        message: "Error inesperado",
        internal: "Excepción no controlada",
        log_code: "ECS-GEN-999"
      }
    }
  end

  def raise_const(key), do: raise(BusinessException, Map.fetch!(constants(), key))
end
