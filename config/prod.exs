use Mix.Config

host =
  System.get_env("APPLICATION_HOST") ||
    raise """
    Missing APPLICATION_HOST.
    This value should be the hostname of the Heroku dyno.
    For example: funny-name.herokuapp.com
    DO NOT FORGET the "herokuapp.com" portion
    """

config :guitar_store, GuitarStoreWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: host, port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :logger, level: :info

import_config "prod.secret.exs"
