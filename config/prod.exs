use Mix.Config

config :guitar_store, GuitarStoreWeb.Endpoint,
  cache_static_manifest: "priv/static/cache_manifest.json",
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  code_reloader: false

# Do not print debug messages in production
config :logger, level: :info
