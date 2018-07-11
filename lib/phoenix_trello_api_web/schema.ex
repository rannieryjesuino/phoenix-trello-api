defmodule PhoenixTrelloApiWeb.Schema do
  use Absinthe.Schema

  alias PhoenixTrelloApiWeb.{ListResolver,BoardResolver}

  object :board do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :lists, list_of(:list)
  end

  object :list do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :quadro, :board
  end

  mutation do
    field :create_board, :board do
      arg :name, non_null(:string)

      resolve &BoardResolver.create_board/3
    end

    field :update_board, :board do
      arg :name, non_null(:string)

      resolve &BoardResolver.update_board/3
    end

    field :delete_board, :board do
      arg :name, non_null(:string)

      resolve &BoardResolver.delete_board/3
    end

    field :create_list, :board do
      arg :name, non_null(:string)

      resolve &ListResolver.create_list/3
    end

    field :update_list, :board do
      arg :name, non_null(:string)

      resolve &ListResolver.update_list/3
    end

    field :delete_list, :board do
      arg :name, non_null(:string)

      resolve &ListResolver.delete_list/3
    end

    field :create_card, :board do
      arg :name, non_null(:string)

      resolve &CardResolver.create_card/3
    end
  end

  query do
    # this is the query entry point to our app
    field :all_boards, non_null(list_of(non_null(:board))) do
      resolve &BoardResolver.all_boards/3
    end

    field :all_lists, non_null(list_of(non_null(:list))) do
      resolve &ListResolver.all_lists/3
    end
  end
end
