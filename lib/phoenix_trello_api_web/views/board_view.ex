defmodule PhoenixTrelloApiWeb.BoardView do
  use PhoenixTrelloApiWeb, :view
  alias PhoenixTrelloApiWeb.BoardView, warn: false

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{
      id: board.id,
      name: board.name
    }
  end
end
