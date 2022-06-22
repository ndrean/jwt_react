# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :jwt_react,
  ecto_repos: [JwtReact.Repo]

# Configures the endpoint
config :jwt_react, JwtReactWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: JwtReactWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: JwtReact.PubSub,
  live_view: [signing_salt: "FyxDQYos"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :jwt_react, JwtReact.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :jwt_react, JwtReact.Guardian,
  issuer: "jwt_react",
  secret_key: "rzbiTOdvZR8ZHp60ugj/obbWm8BOOGj1HLL8KYYmR27jlfVQ3c4jQyW6aGtf0Axv"

# Used `mix guardian.gen.secret` to generate a "secret_key"

# Rate limiter with native ETS
config :hammer,
  backend: {Hammer.Backend.ETS, [expiry_ms: 60_000 * 60 * 4, cleanup_interval_ms: 60_000 * 10]}

# Rate limiter with multiple backends
# config :hammer,
#   backend: [
#     ets: {
#       Hammer.Backend.ETS,
#       [
#         ets_table_name: :hammer_backend_ets_buckets,
#         expiry_ms: 60_000 * 60 * 2,
#         cleanup_interval_ms: 60_000 * 2,
#       ]
#     },
#     redis: {
#       Hammer.Backend.Redis,
#       [
#         expiry_ms: 60_000 * 60 * 2,
#         redix_config: [host: "localhost", port: 6379],
#         pool_size: 4,
#       ]
#     }
#   ]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
