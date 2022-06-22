import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :jwt_react, JwtReact.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "jwt_react_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jwt_react, JwtReactWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ODb65iV0XNHStd9apz714qgv0f89vUCfFtwPw/cDptcuqHbXrFzZQ474dwRycBwD",
  server: false

# In test we don't send emails.
config :jwt_react, JwtReact.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
