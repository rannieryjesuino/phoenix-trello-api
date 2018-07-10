defmodule PhoenixTrelloApi.Trello.Card do
  use Ecto.Schema
  import Ecto.Changeset


  schema "cards" do
    field :desc, :string
    field :name, :string
    belongs_to :list, PhoenixTrelloApi.Trello.List

    timestamps()
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:name, :desc, :list_id])
    |> validate_required([:name, :desc])
    |> assoc_constraint(:list)
  end
end
