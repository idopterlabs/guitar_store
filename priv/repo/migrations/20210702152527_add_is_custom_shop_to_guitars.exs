defmodule GuitarStore.Repo.Migrations.AddIsCustomShopToGuitars do
  use Ecto.Migration

  def change do
    alter table("guitars") do
      add :is_custom_shop, :boolean, default: false
    end

    create index("guitars", ["is_custom_shop"])
  end
end
