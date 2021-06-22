defmodule GuitarStore.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias GuitarStore.Repo

  alias GuitarStore.Inventory.Guitar

  @doc """
  Returns the list of guitars.

  ## Examples

      iex> list_guitars()
      [%Guitar{}, ...]

  """
  def list_guitars do
    Repo.all(Guitar)
  end

  @doc """
  Gets a single guitar.

  Raises `Ecto.NoResultsError` if the Guitar does not exist.

  ## Examples

      iex> get_guitar!(123)
      %Guitar{}

      iex> get_guitar!(456)
      ** (Ecto.NoResultsError)

  """
  def get_guitar!(id), do: Repo.get!(Guitar, id)

  @doc """
  Creates a guitar.

  ## Examples

      iex> create_guitar(%{field: value})
      {:ok, %Guitar{}}

      iex> create_guitar(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_guitar(attrs \\ %{}) do
    %Guitar{}
    |> Guitar.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a guitar.

  ## Examples

      iex> update_guitar(guitar, %{field: new_value})
      {:ok, %Guitar{}}

      iex> update_guitar(guitar, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_guitar(%Guitar{} = guitar, attrs) do
    guitar
    |> Guitar.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a guitar.

  ## Examples

      iex> delete_guitar(guitar)
      {:ok, %Guitar{}}

      iex> delete_guitar(guitar)
      {:error, %Ecto.Changeset{}}

  """
  def delete_guitar(%Guitar{} = guitar) do
    Repo.delete(guitar)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking guitar changes.

  ## Examples

      iex> change_guitar(guitar)
      %Ecto.Changeset{data: %Guitar{}}

  """
  def change_guitar(%Guitar{} = guitar, attrs \\ %{}) do
    Guitar.changeset(guitar, attrs)
  end
end
