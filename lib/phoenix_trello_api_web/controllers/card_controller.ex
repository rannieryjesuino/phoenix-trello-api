defmodule PhoenixTrelloApiWeb.CardController do
  use PhoenixTrelloApiWeb, :controller

  alias PhoenixTrelloApi.Trello
  alias PhoenixTrelloApi.Trello.Card

  action_fallback PhoenixTrelloApiWeb.FallbackController

  def index(conn, _params) do
    cards = Trello.list_cards()
    render(conn, "index.json", cards: cards)
  end

  def create(conn, %{"card" => card_params}) do
    with {:ok, %Card{} = card} <- Trello.create_card(card_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", card_path(conn, :show, card))
      |> render("show.json", card: card)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Trello.get_card!(id)
    render(conn, "show.json", card: card)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Trello.get_card!(id)

    with {:ok, %Card{} = card} <- Trello.update_card(card, card_params) do
      render(conn, "show.json", card: card)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Trello.get_card!(id)
    with {:ok, %Card{}} <- Trello.delete_card(card) do
      send_resp(conn, :no_content, "Card deletado!")
    end
  end
end
