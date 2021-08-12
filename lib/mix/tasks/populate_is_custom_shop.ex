defmodule Mix.Tasks.PopulateIsCustomShop do
  @moduledoc """
  This task populates the is_custom_shop column
  in the database for existing records
  """
  @shortdoc "Populates is_custom_shop column"

  use Mix.Task

  import Ecto.Query
  alias GuitarStore.Inventory.Guitar
  alias GuitarStore.{Repo, Utils}

  @requirements ["app.start"]

  def run(_) do
    Enum.map(Utils.custom_shop_entries(), &update_guitars/1)
  end

  defp update_guitars({make, model, year}) do
    from(g in Guitar,
      where: g.make == ^make and g.model == ^model and g.year == ^year,
      select: g
    )
    |> Repo.update_all(set: [is_custom_shop: true])
  end
end
