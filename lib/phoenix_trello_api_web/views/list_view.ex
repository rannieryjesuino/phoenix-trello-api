defmodule PhoenixTrelloApiWeb.ListView do
  use PhoenixTrelloApiWeb, :view
  alias PhoenixTrelloApiWeb.ListView, warn: false

  def render("index.json", %{lists: lists}) do
    Enum.map(lists, fn list ->
      %{
        id: list.id,
        name: list.name,
        board_id: list.board_id
      }
    end)
  end

  def render("show.json", %{list: list}) do
    %{
      id: list.id,
      name: list.name,
      board_id: list.board_id
    }
  end

  def render("list.json", %{list: list}) do
    %{
      id: list.id,
      name: list.name,
      board_id: list.board.id,
      board_name: list.board.name
    }
  end
end
