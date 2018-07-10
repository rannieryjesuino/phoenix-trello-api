defmodule PhoenixTrelloApiWeb.Router do
  use PhoenixTrelloApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", PhoenixTrelloApiWeb do
  #   pipe_through :browser # Use the default browser stack
  #
  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixTrelloApiWeb do
    pipe_through :api

    resources "/boards", BoardController, except: [:new, :edit]
    resources "/lists", ListController, except: [:new, :edit]
    resources "/cards", CardController, except: [:new, :edit]
  end
end
