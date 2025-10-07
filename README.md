Reto Auth – Elixir (in-memory)

API de autenticación mínima basada en Plug + Cowboy con persistencia en memoria (ETS).

Cumple el manifiesto y los criterios del reto:

•	Endpoints: POST /signup, POST /signin
•	Trazabilidad obligatoria: headers message-id (UUID) y x-request-id (UUID; fallback al message-id)
•	Persistencia: ETS (listas hash en memoria, sin BD)
•	Errores canónicos: mapeados a HTTP y viajan como un solo tipo

________________________________________
Requisitos
•	Elixir ≥ 1.15
•	Erlang/OTP ≥ 26
•	Puerto libre 8080
________________________________________
Ejecutar
mix deps.get
mix run --no-halt
Servidor en: http://localhost:8080
Para modo interactivo: iex -S mix
________________________________________
Endpoints
POST /signup → 201 (sin body)
Registra un usuario en memoria.
•	Headers obligatorios
message-id: <uuid>
x-request-id: <uuid> (si no viene, el server usa el message-id)
•	Body (JSON)
•	{
•	  "email": "user@example.com",
•	  "password": "S3guro!2025",
•	  "name": "Ada"
•	}

Errores

•	409 EMAIL_ALREADY_EXISTS
•	400 MALFORMED_REQUEST, 400 INVALID_EMAIL_FORMAT, 400 WEAK_PASSWORD

________________________________________

POST /signin → 200

Autentica y genera sesión.
•	Headers obligatorios
message-id: <uuid>
x-request-id: <uuid> (fallback)

•	Body (JSON)

•	{
•	  "email": "user@example.com",
•	  "password": "S3guro!2025"
•	}
•	Respuesta 200 (JSON)
•	{ "session_id": "<uuid>" }

Errores
•	404 USER_NOT_FOUND
•	401 INVALID_CREDENTIALS
•	400 MALFORMED_REQUEST
________________________________________
OpenAPI
•	Spec: GET /openapi.yaml
•	Puedes abrirla en Swagger-UI local o importarla en Postman/Insomnia.

