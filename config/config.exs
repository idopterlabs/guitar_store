# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :guitar_store,
  ecto_repos: [GuitarStore.Repo]

# Configures the endpoint
config :guitar_store, GuitarStoreWeb.Endpoint,
  server: true,
  url: [host: "localhost"],
  secret_key_base: "F6maxWzkVxdiaUPyghSJOPW5ME0h0KIhc1qSsGCbYDEbPyNtdManhgu34OqVwHs0",
  render_errors: [view: GuitarStoreWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GuitarStore.PubSub,
  live_view: [signing_salt: "Artvq/Ge"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
