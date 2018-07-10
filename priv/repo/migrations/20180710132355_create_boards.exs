defmodule PhoenixTrelloApi.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :name, :string, null: false

      timestamps()
    end

  end
end
