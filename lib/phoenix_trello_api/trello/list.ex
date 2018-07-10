defmodule PhoenixTrelloApi.Trello.List do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lists" do
    field :name, :string
    belongs_to :board, PhoenixTrelloApi.Trello.Board
    has_many :cards, PhoenixTrelloApi.Trello.Card

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :board_id])
    |> validate_required([:name])
    |> assoc_constraint(:board)
  end
end
