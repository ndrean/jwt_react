defmodule JwtReact.Repo do
  use Ecto.Repo,
    otp_app: :jwt_react,
    adapter: Ecto.Adapters.Postgres
end
