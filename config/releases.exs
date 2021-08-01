import Config

is_local = System.get_env("IS_LOCAL") == "true"

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :guitar_store, GuitarStore.Repo,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

if !is_local do
  config :guitar_store, GuitarStore.Repo, ssl: true
end

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

application_port = String.to_integer(System.fetch_env!("PORT"))

config :guitar_store, GuitarStoreWeb.Endpoint,
  url: [
    scheme: System.get_env("APPLICATION_PROTOCOL", "https"),
    host: System.get_env("APPLICATION_HOST", "safe-lake-80313.herokuapp.com"),
    port: application_port
  ],
  http: [
    port: application_port,
    transport_options: [socket_opts: []]
  ],
  secret_key_base: secret_key_base

config :guitar_store, GuitarStoreWeb.Endpoint, server: true
