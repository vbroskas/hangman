defmodule Hangman do
  @moduledoc """
  API interface
  """

  @doc """
  create new game
  """

  def new_game() do
    Hangman.Server.start_link()
  end

  def make_move(game_pid, guess) do
    GenServer.call(game_pid, {:make_move, guess})
  end

  def get_tally(game_pid) do
    GenServer.call(game_pid, {:get_tally})
  end
end
