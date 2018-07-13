defmodule PhoenixTrelloApiWeb.CardResolver do

  alias PhoenixTrelloApi.Trello


  def all_cards(_root, _args, _info) do
    cards = Trello.list_cards()
    {:ok, cards}
  end

  def create_card(_root, args, _info) do
    case Trello.create_card(args) do
      {:ok, card} ->
        {:ok, card}
      {:error, changeset} ->
        {
          :error,
          message: "could not create card",
          details: Trello.error_details(changeset)
        }
      _error ->
        {:error, "could not create card"}
    end
  end

  def update_card(_root, args, _info) do
    card = Trello.get_card!(args.id)
    case Trello.update_card(card, args) do
      {:ok, card} ->
        {:ok, card}
      {:error, reason} ->
        {:error, reason}
      {:error, changeset} ->
        {
          :error,
          message: "could not update card",
          details: Trello.error_details(changeset)
        }
      _error ->
        {:error, "could not update card"}
    end
  end

  def delete_card(_root, args, _info) do
    card = Trello.get_card!(args.id)
    Trello.delete_card(card)
  end

end
