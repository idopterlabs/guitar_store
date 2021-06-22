defmodule GuitarStore.Repo do
  use Ecto.Repo,
    otp_app: :guitar_store,
    adapter: Ecto.Adapters.Postgres
end
