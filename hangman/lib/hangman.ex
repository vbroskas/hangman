defmodule Hangman do
  @moduledoc """
  API interface
  """
  alias Hangman.Game

  @doc """
  create new game
  """
  defdelegate new_game(), to: Game

  @doc """
  get status of current game
  """
  defdelegate tally(game), to: Game

  defdelegate make_move(game, guess), to: Game
end
