defmodule PhoenixTrelloApiWeb.Schema do
  use Absinthe.Schema

  alias PhoenixTrelloApiWeb.{CardResolver, ListResolver, BoardResolver}

  object :board do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :lists, list_of(:list)
  end

  object :list do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :board_id, non_null(:integer)
  end

  object :card do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :desc, :string
    field :list_id, non_null(:integer)
  end

  mutation do
    field :create_board, :board do
      arg :name, non_null(:string)

      resolve &BoardResolver.create_board/3
    end

    field :update_board, :board do
      arg :id, non_null(:integer)
      arg :name, non_null(:string)

      resolve &BoardResolver.update_board/3
    end

    field :delete_board, :board do
      arg :id, non_null(:integer)

      resolve &BoardResolver.delete_board/3
    end

    field :create_list, :list do
      arg :name, non_null(:string)
      arg :board_id, non_null(:integer)

      resolve &ListResolver.create_list/3
    end

    field :update_list, :list do
      arg :id, non_null(:integer)
      arg :name, non_null(:string)
      arg :board_id, non_null(:integer)

      resolve &ListResolver.update_list/3
    end

    field :delete_list, :list do
      arg :id, non_null(:integer)
      arg :target_id, :integer

      resolve &ListResolver.delete_list/3
    end

    field :create_card, :card do
      arg :name, non_null(:string)
      arg :desc, :string
      arg :list_id, non_null(:integer)

      resolve &CardResolver.create_card/3
    end

    field :update_card, :card do
      arg :id, non_null(:integer)
      arg :name, :string
      arg :desc, :string
      arg :list_id, non_null(:integer)

      resolve &CardResolver.update_card/3
    end

    field :delete_card, :card do
      arg :id, non_null(:integer)

      resolve &CardResolver.delete_card/3
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

    field :all_cards, non_null(list_of(non_null(:card))) do
      resolve &CardResolver.all_cards/3
    end
  end
end
