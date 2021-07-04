defmodule GuitarStore.InventoryTest do
  use GuitarStore.DataCase

  alias GuitarStore.Inventory

  describe "guitars" do
    alias GuitarStore.Inventory.Guitar

    @valid_attrs %{make: "some make", model: "some model", year: 42}
    @update_attrs %{make: "some updated make", model: "some updated model", year: 43}
    @invalid_attrs %{make: nil, model: nil, year: nil}

    def guitar_fixture(attrs \\ %{}) do
      {:ok, guitar} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Inventory.create_guitar()

      guitar
    end

    test "list_guitars/0 returns all guitars" do
      guitar = guitar_fixture()
      assert Inventory.list_guitars() == [guitar]
    end

    test "get_guitar!/1 returns the guitar with given id" do
      guitar = guitar_fixture()
      assert Inventory.get_guitar!(guitar.id) == guitar
    end

    test "create_guitar/1 with valid data creates a guitar" do
      assert {:ok, %Guitar{} = guitar} = Inventory.create_guitar(@valid_attrs)
      assert guitar.make == "some make"
      assert guitar.model == "some model"
      assert guitar.year == 42

      as_custom_shop = @valid_attrs |> Map.put(:is_custom_shop, true)
      assert {:ok, %Guitar{} = guitar} = Inventory.create_guitar(as_custom_shop)

      assert guitar.is_custom_shop
    end

    test "create_guitar/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_guitar(@invalid_attrs)
    end

    test "update_guitar/2 with valid data updates the guitar" do
      guitar = guitar_fixture()
      assert {:ok, %Guitar{} = guitar} = Inventory.update_guitar(guitar, @update_attrs)
      assert guitar.make == "some updated make"
      assert guitar.model == "some updated model"
      assert guitar.year == 43
    end

    test "update_guitar/2 with invalid data returns error changeset" do
      guitar = guitar_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_guitar(guitar, @invalid_attrs)
      assert guitar == Inventory.get_guitar!(guitar.id)
    end

    test "delete_guitar/1 deletes the guitar" do
      guitar = guitar_fixture()
      assert {:ok, %Guitar{}} = Inventory.delete_guitar(guitar)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_guitar!(guitar.id) end
    end

    test "change_guitar/1 returns a guitar changeset" do
      guitar = guitar_fixture()
      assert %Ecto.Changeset{} = Inventory.change_guitar(guitar)
    end
  end
end
