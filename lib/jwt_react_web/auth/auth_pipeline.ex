defmodule JwtReact.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :jwt_react,
    module: JwtReact.Guardian,
    error_handler: JwtReact.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
