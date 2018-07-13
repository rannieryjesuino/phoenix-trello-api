defmodule PhoenixTrelloApiWeb.BoardController do
  use PhoenixTrelloApiWeb, :controller

  alias PhoenixTrelloApi.Trello
  alias PhoenixTrelloApi.Trello.Board

  action_fallback PhoenixTrelloApiWeb.FallbackController

  def index(conn, _params) do
    boards = Trello.list_boards()
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    with {:ok, %Board{} = board} <- Trello.create_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", board_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def show(conn, %{"id" => id}) do
    board = Trello.get_board!(id)
    render(conn, "show.json", board: board)
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Trello.get_board!(id)

    with {:ok, %Board{} = board} <- Trello.update_board(board, board_params) do
      render(conn, "show.json", board: board)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Trello.get_board!(id)
    with {:ok, %Board{}} <- Trello.delete_board(board) do
      send_resp(conn, :no_content, "Board deletada!")
    end
  end
end
