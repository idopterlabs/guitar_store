defmodule GuitarStoreWeb.GuitarController do
  use GuitarStoreWeb, :controller

  alias GuitarStore.Inventory
  alias GuitarStore.Inventory.Guitar

  def index(conn, _params) do
    guitars = Inventory.list_guitars()
    render(conn, "index.html", guitars: guitars)
  end

  def new(conn, _params) do
    changeset = Inventory.change_guitar(%Guitar{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"guitar" => guitar_params}) do
    case Inventory.create_guitar(guitar_params) do
      {:ok, guitar} ->
        conn
        |> put_flash(:info, "Guitar created successfully.")
        |> redirect(to: Routes.guitar_path(conn, :show, guitar))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    guitar = Inventory.get_guitar!(id)
    render(conn, "show.html", guitar: guitar)
  end

  def edit(conn, %{"id" => id}) do
    guitar = Inventory.get_guitar!(id)
    changeset = Inventory.change_guitar(guitar)
    render(conn, "edit.html", guitar: guitar, changeset: changeset)
  end

  def update(conn, %{"id" => id, "guitar" => guitar_params}) do
    guitar = Inventory.get_guitar!(id)

    case Inventory.update_guitar(guitar, guitar_params) do
      {:ok, guitar} ->
        conn
        |> put_flash(:info, "Guitar updated successfully.")
        |> redirect(to: Routes.guitar_path(conn, :show, guitar))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", guitar: guitar, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    guitar = Inventory.get_guitar!(id)
    {:ok, _guitar} = Inventory.delete_guitar(guitar)

    conn
    |> put_flash(:info, "Guitar deleted successfully.")
    |> redirect(to: Routes.guitar_path(conn, :index))
  end
end
