defmodule GuitarStoreWeb.GuitarControllerTest do
  use GuitarStoreWeb.ConnCase

  alias GuitarStore.Inventory

  @create_attrs %{make: "some make", model: "some model", year: 42}
  @update_attrs %{make: "some updated make", model: "some updated model", year: 43}
  @invalid_attrs %{make: nil, model: nil, year: nil}

  def fixture(:guitar) do
    {:ok, guitar} = Inventory.create_guitar(@create_attrs)
    guitar
  end

  describe "index" do
    test "lists all guitars", %{conn: conn} do
      conn = get(conn, Routes.guitar_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Guitars"
    end
  end

  describe "new guitar" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.guitar_path(conn, :new))
      assert html_response(conn, 200) =~ "New Guitar"
    end
  end

  describe "create guitar" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.guitar_path(conn, :create), guitar: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.guitar_path(conn, :show, id)

      conn = get(conn, Routes.guitar_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Guitar"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.guitar_path(conn, :create), guitar: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Guitar"
    end
  end

  describe "edit guitar" do
    setup [:create_guitar]

    test "renders form for editing chosen guitar", %{conn: conn, guitar: guitar} do
      conn = get(conn, Routes.guitar_path(conn, :edit, guitar))
      assert html_response(conn, 200) =~ "Edit Guitar"
    end
  end

  describe "update guitar" do
    setup [:create_guitar]

    test "redirects when data is valid", %{conn: conn, guitar: guitar} do
      conn = put(conn, Routes.guitar_path(conn, :update, guitar), guitar: @update_attrs)
      assert redirected_to(conn) == Routes.guitar_path(conn, :show, guitar)

      conn = get(conn, Routes.guitar_path(conn, :show, guitar))
      assert html_response(conn, 200) =~ "some updated make"
    end

    test "renders errors when data is invalid", %{conn: conn, guitar: guitar} do
      conn = put(conn, Routes.guitar_path(conn, :update, guitar), guitar: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Guitar"
    end
  end

  describe "delete guitar" do
    setup [:create_guitar]

    test "deletes chosen guitar", %{conn: conn, guitar: guitar} do
      conn = delete(conn, Routes.guitar_path(conn, :delete, guitar))
      assert redirected_to(conn) == Routes.guitar_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.guitar_path(conn, :show, guitar))
      end
    end
  end

  defp create_guitar(_) do
    guitar = fixture(:guitar)
    %{guitar: guitar}
  end
end
