defmodule PhoenixTrelloApi.Repo.Migrations.CreateCards do
  use Ecto.Migration

  def change do
    create table(:cards) do
      add :name, :string, null: false
      add :desc, :text
      add :list_id, references(:lists, on_delete: :delete_all)

      timestamps()
    end

    create index(:cards, [:list_id])
  end
end
