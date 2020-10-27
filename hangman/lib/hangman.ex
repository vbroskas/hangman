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

  def make_move(game, guess) do
    check_guess(guess)
    game = Game.make_move(game, guess)
    {game, tally(game)}
  end

  defp check_guess(guess) do
  end
end
