defmodule PhoenixTrelloApiWeb.CardView do
  use PhoenixTrelloApiWeb, :view
  alias PhoenixTrelloApiWeb.CardView, warn: false

  def render("index.json", %{cards: cards}) do
    Enum.map(cards, fn card ->
      %{
        id: card.id,
        name: card.name,
        desc: card.desc,
        list_id: card.list_id
      }
    end)
  end

  def render("show.json", %{card: card}) do
    %{
      id: card.id,
      name: card.name,
      desc: card.desc,
      list_id: card.list_id
    }
  end

  def render("card.json", %{card: card}) do
    %{
      id: card.id,
      name: card.name,
      desc: card.desc
    }
  end
end
