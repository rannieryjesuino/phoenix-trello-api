defmodule PhoenixTrelloApiWeb.ListResolver do

  alias PhoenixTrelloApi.{Trello, Repo}


  def all_lists(_root, _args, _info) do
    lists = Trello.list_lists()
    lists = Repo.preload(lists, :board)
    {:ok, lists}
  end

  def create_list(_root, args, _info) do
    case Trello.create_list(args) do
      {:ok, list} ->
        {:ok, list}
      {:error, changeset} ->
        {
          :error,
          message: "could not create list",
          details: Trello.error_details(changeset)
        }
      _error ->
        {:error, "could not create list"}
    end
  end

  def update_list(_root, args, _info) do
    list = Trello.get_list!(args.id)
    case Trello.update_list(list, args) do
      {:ok, list} ->
        {:ok, list}
      {:error, changeset} ->
        {
          :error,
          message: "could not update list",
          details: Trello.error_details(changeset)
        }
      _error ->
        {:error, "could not update list"}
    end
  end

  def delete_list(_root, args, _info) do
    list = Trello.get_list!(args.id)
    if args.target_id do
      Trello.delete_list(list, args.target_id)
    else
      Trello.delete_list(list)
    end
  end

end
