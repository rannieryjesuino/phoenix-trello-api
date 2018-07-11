defmodule PhoenixTrelloApiWeb.CardResolver do

  alias PhoenixTrelloApi.Trello


  def all_cards(_root, _args, _info) do
    cards = Trello.list_cards()
    {:ok, lists}
  end

  def create_card(_root, args, _info) do
    case Trello.create_card(args) do
      {:ok, card} ->
        {:ok, card}
      _error ->
        {:error, "could not create card"}
    end
  end

  def update_card(_root, args, _info) do
    case Trello.update_card(args) do
      {:ok, card} ->
        {:ok, card}
      _error ->
        {:error, "could not update card"}
    end
  end

  def delete_card(_root, args, _info) do
    Trello.delete_card(args)
  end

end
