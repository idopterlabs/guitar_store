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
  url: [host: "localhost"],
  secret_key_base: "F6maxWzkVxdiaUPyghSJOPW5ME0h0KIhc1qSsGCbYDEbPyNtdManhgu34OqVwHs0",
  render_errors: [view: GuitarStoreWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GuitarStore.PubSub,
  live_view: [signing_salt: "Artvq/Ge"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :trace_id, :span_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :spandex, :decorators, tracer: GuitarStore.Tracer
config :spandex_phoenix, tracer: GuitarStore.Tracer

config :guitar_store, GuitarStore.Tracer,
  adapter: SpandexDatadog.Adapter,
  service: :"guitar-store",
  type: :web,
  disabled?: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

# base_opts = [
#   adapter: SpandexDatadog.Adapter,
#   strategy: Spandex.Strategy.Pdict,
#   env: "prod"
# ]

# span_opts = [
#   service: :"guitar-store",
#   resource: "Inventory.list_available_guitars()"
# ]

# opts = base_opts ++ span_opts

# GuitarStore.Tracer.start_trace("listing global inventory for sale", opts)
# GuitarStore.Tracer.current_span(base_opts)
# GuitarStore.Tracer.start_span("listing_guitars", span_opts)
# GuitarStore.Tracer.finish_span(base_opts)
# GuitarStore.Tracer.start_span("checking against others stores", span_opts)
# GuitarStore.Tracer.start_span("checking against others stores 2", span_opts)
# GuitarStore.Tracer.finish_span(base_opts)
# GuitarStore.Tracer.finish_span(base_opts)
# GuitarStore.Tracer.start_span("checking against police database", span_opts)
# GuitarStore.Tracer.finish_span(base_opts)
# GuitarStore.Tracer.finish_trace()
