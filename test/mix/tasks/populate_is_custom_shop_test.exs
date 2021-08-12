defmodule Mix.Tasks.PopulateIsCustomShopTest do
  use GuitarStore.DataCase

  alias Mix.Tasks.PopulateIsCustomShop
  alias GuitarStore.Utils

  alias GuitarStore.Inventory

  @custom_shop_entries Utils.custom_shop_entries()

  test "populates custom shop field" do
    # Create 1 custom shop with flag false
    [{make, model, year} | _] = @custom_shop_entries

    {:ok, custom} =
      Inventory.create_guitar(%{
        make: make,
        model: model,
        year: year
      })

    # Create 1 non-custom shop with flag false
    {:ok, non_custom} =
      Inventory.create_guitar(%{
        make: "#{make}-non-custom",
        model: model,
        year: year
      })

    refute custom.is_custom_shop
    refute non_custom.is_custom_shop

    # Run task
    PopulateIsCustomShop.run([])

    # custom shop should have flag true
    custom = Inventory.get_guitar!(custom.id)
    assert custom.is_custom_shop
    # non-custom shop should have flag false
    non_custom = Inventory.get_guitar!(non_custom.id)
    refute non_custom.is_custom_shop
  end
end
