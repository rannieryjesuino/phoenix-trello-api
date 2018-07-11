defmodule PhoenixTrelloApiWeb.Schema do
  use Absinthe.Schema

  alias PhoenixTrelloApiWeb.BoardResolver

  object :board do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :lists, list_of(:list)
  end

  object :list do
    field :id, non_null(:id)
    field :name, non_null(:string)
  end

  mutation do
    field :create_board, :board do
      arg :name, non_null(:string)

      resolve &BoardResolver.create_board/3
    end
  end

  query do
    # this is the query entry point to our app
    field :all_boards, non_null(list_of(non_null(:board))) do
      resolve &BoardResolver.all_boards/3
    end
  end
end
