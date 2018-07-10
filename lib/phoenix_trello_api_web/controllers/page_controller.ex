defmodule PhoenixTrelloApiWeb.PageController do
  use PhoenixTrelloApiWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
