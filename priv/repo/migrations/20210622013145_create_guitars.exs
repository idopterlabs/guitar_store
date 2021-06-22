defmodule GuitarStore.Repo.Migrations.CreateGuitars do
  use Ecto.Migration

  def change do
    create table(:guitars) do
      add :make, :string
      add :model, :string
      add :year, :integer

      timestamps()
    end

  end
end
