import Config

config :guitar_store, GuitarStore.Repo,
  username: "postgres",
  password: "postgres",
  database: "guitar_store_dev",
  hostname: "postgres",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

secret_key_base = "F6maxWzkVxdiaUPyghSJOPW5ME0h0KIhc1qSsGCbYDEbPyNtdManhgu34OqVwHs0"

config :guitar_store, GuitarStoreWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :guitar_store, GuitarStoreWeb.Endpoint, server: true
