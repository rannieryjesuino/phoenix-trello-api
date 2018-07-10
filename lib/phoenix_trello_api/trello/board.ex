defmodule PhoenixTrelloApi.Trello.Board do
  use Ecto.Schema
  import Ecto.Changeset


  schema "boards" do
    field :name, :string
    has_many :lists, PhoenixTrelloApi.Trello.List

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
