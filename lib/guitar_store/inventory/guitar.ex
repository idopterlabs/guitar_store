defmodule GuitarStore.Inventory.Guitar do
  use Ecto.Schema
  import Ecto.Changeset

  schema "guitars" do
    field :make, :string
    field :model, :string
    field :year, :integer
    field :is_custom_shop, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(guitar, attrs) do
    guitar
    |> cast(attrs, [:make, :model, :year, :is_custom_shop])
    |> validate_required([:make, :model, :year])
  end
end
