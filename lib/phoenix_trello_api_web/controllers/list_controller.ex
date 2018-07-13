defmodule PhoenixTrelloApiWeb.ListController do
  use PhoenixTrelloApiWeb, :controller

  alias PhoenixTrelloApi.Trello
  alias PhoenixTrelloApi.Trello.List


  action_fallback PhoenixTrelloApiWeb.FallbackController

  def index(conn, _params) do
    lists = Trello.list_lists()
    render(conn, "index.json", lists: lists)
  end

  def create(conn, %{"list" => list_params}) do
    with {:ok, %List{} = list} <- Trello.create_list(list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", list_path(conn, :show, list))
      |> render("show.json", list: list)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Trello.get_list!(id)
    render(conn, "show.json", list: list)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Trello.get_list!(id)

    with {:ok, %List{} = list} <- Trello.update_list(list, list_params) do
      render(conn, "show.json", list: list)
    end
  end

  def delete(conn, %{"id" => id, "target_id" => target_id}) do
    list = Trello.get_list!(id)

    with {:ok, %List{}} <- Trello.delete_list(list) do
      send_resp(conn, :no_content, "Lista deletada!")
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Trello.get_list!(id)

    with {:ok, %List{}} <- Trello.delete_list(list) do
      send_resp(conn, :no_content, "Lista deletada!")
    end
  end
end
