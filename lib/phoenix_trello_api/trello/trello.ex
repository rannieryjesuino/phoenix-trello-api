defmodule PhoenixTrelloApi.Trello do
  @moduledoc """
  The Trello context.
  """

  import Ecto.Query, warn: false
  import Ecto, warn: false
  alias PhoenixTrelloApi.Repo

  alias PhoenixTrelloApi.Trello.Board
  alias PhoenixTrelloApi.Trello.List
  alias PhoenixTrelloApi.Trello.Card

  @doc """
  Returns the list of boards.

  ## Examples

      iex> list_boards()
      [%Board{}, ...]

  """

  def error_details(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {msg, _} -> msg end)
 end

  def list_boards do
    Repo.all(Board)
    |> Repo.preload(:lists)
  end

  @doc """
  Gets a single board.

  Raises `Ecto.NoResultsError` if the Board does not exist.

  ## Examples

      iex> get_board!(123)
      %Board{}

      iex> get_board!(456)
      ** (Ecto.NoResultsError)

  """
  def get_board!(id), do: Repo.get!(Board, id) |> Repo.preload(:lists)

  @doc """
  Creates a board.

  ## Examples

      iex> create_board(%{field: value})
      {:ok, %Board{}}

      iex> create_board(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_board(attrs \\ %{}) do
    {status, board} = %Board{}
    |> Board.changeset(attrs)
    |> Repo.insert()

    if status == :ok do
      Ecto.build_assoc(board, :lists, name: "To Do")
      |> Repo.insert!()
      Ecto.build_assoc(board, :lists, name: "Doing")
      |> Repo.insert!()
      Ecto.build_assoc(board, :lists, name: "Done")
      |> Repo.insert!()
    end

    {status, board}
  end

  @doc """
  Updates a board.

  ## Examples

      iex> update_board(board, %{field: new_value})
      {:ok, %Board{}}

      iex> update_board(board, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_board(%Board{} = board, attrs) do
    board
    |> Board.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Board.

  ## Examples

      iex> delete_board(board)
      {:ok, %Board{}}

      iex> delete_board(board)
      {:error, %Ecto.Changeset{}}

  """
  def delete_board(%Board{} = board) do
    Repo.delete(board)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking board changes.

  ## Examples

      iex> change_board(board)
      %Ecto.Changeset{source: %Board{}}

  """
  def change_board(%Board{} = board) do
    Board.changeset(board, %{})
  end

  @doc """
  Returns the list of lists.

  ## Examples

      iex> list_lists()
      [%List{}, ...]

  """
  def list_lists do
    Repo.all(List)
    |> Repo.preload(:board)
  end

  @doc """
  Gets a single list.

  Raises `Ecto.NoResultsError` if the List does not exist.

  ## Examples

      iex> get_list!(123)
      %List{}

      iex> get_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_list!(id), do: Repo.get!(List, id) |> Repo.preload(:board)

  @doc """
  Creates a list.

  ## Examples

      iex> create_list(%{field: value})
      {:ok, %List{}}

      iex> create_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_list(attrs \\ %{}) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a list.

  ## Examples

      iex> update_list(list, %{field: new_value})
      {:ok, %List{}}

      iex> update_list(list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_list(%List{} = list, attrs) do
    if attrs.board_id != list.board_id do
      {:error, "Board diferente da lista original!"}
    else
      list
      |> List.changeset(attrs)
      |> Repo.update()
    end
  end

  @doc """
  Deletes a List.

  ## Examples

      iex> delete_list(list)
      {:ok, %List{}}

      iex> delete_list(list)
      {:error, %Ecto.Changeset{}}

  """

  def delete_list(%List{} = list, target_id) do
    list = Repo.preload(list, :cards)

    move_cards(list.cards, target_id)

    Repo.delete(list)
  end

  defp move_cards(cards, target_id) do
    for card <- cards do
      update_card(card, %{list_id: target_id})
    end
  end

  def delete_list(%List{} = list) do
    Repo.delete(list)
  end

  def get_cards(%List{} = list) do
    list = Repo.preload(list, :cards)
    from(c in Card, where: c.list_id == ^list.id)
    |> Repo.all
    |> preload_card()
  end

  defp preload_card(card_or_cards) do
    Repo.preload(card_or_cards, :list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking list changes.

  ## Examples

      iex> change_list(list)
      %Ecto.Changeset{source: %List{}}

  """
  def change_list(%List{} = list) do
    List.changeset(list, %{})
  end

  @doc """
  Returns the list of cards.

  ## Examples

      iex> list_cards()
      [%Card{}, ...]

  """
  def list_cards do
    Repo.all(Card)
    |> Repo.preload(:list)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id) |> Repo.preload(:list)

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    if get_lists_board(card.list_id) != get_lists_board(attrs.list_id) do
      {:error, "Board da lista destino e diferente"}
    else
      card
      |> Card.changeset(attrs)
      |> Repo.update()
    end

  end

  def get_lists_board(list_id) do
    list = Repo.get!(List, list_id)
    query = from board in Board, where: ^list.board_id == board.id
    board = Repo.one(query)
  end
  @doc """
  Deletes a Card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{source: %Card{}}

  """
  def change_card(%Card{} = card) do
    Card.changeset(card, %{})
  end
end
