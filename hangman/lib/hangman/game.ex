defmodule Hangman.Game do
  @moduledoc """
  internal functions for a game
  """
  alias Hangman.Game

  defstruct turns_left: 5, game_state: :initializing, letters: [], guesses: MapSet.new()

  def new_game_with_word(word) do
    letters = word |> String.codepoints()
    %Game{letters: letters}
  end

  def new_game() do
    letters = Dictionary.get_random_word() |> String.codepoints()
    %Game{letters: letters}
  end

  @doc """
  On a move, check if game has been won or lost
  """
  def make_move(%Game{game_state: state} = game, _guess) when state in [:won, :lost] do
    game
  end

  @doc """
  Make move when game hasnt been won/lost, process the guess
  """
  def make_move(%Game{guesses: guesses} = game, guess) do
    # check if guess is already in :guesses MapSet
    game = accept_move(game, guess, MapSet.member?(guesses, guess))
    game
  end

  def tally(game) do
    %{
      game_state: game.game_state,
      turns_left: game.turns_left,
      display_letters: game.letters |> reveal_guessed(game.guesses),
      letters_guessed: game.guesses
    }
  end

  # ------------Private Calls-----------------------

  @doc """
  found bug where a letter was guessed on the last remaining move that had already been guessed previsouly
  This resulted in the turn_left counter going past 0 and giving player indefinate guesses
  """
  defp accept_move(game = %Game{turns_left: 1}, _guess, _already_guessed = true) do
    IO.puts("NO BUG HERE!")
    Map.put(game, :game_state, :lost)
  end

  @doc """
  letter has already been guessed
  """
  defp accept_move(game, _guess, _already_guessed = true) do
    # update game_state
    turns_left = game.turns_left
    %{game | game_state: :already_used, turns_left: turns_left - 1}
  end

  @doc """
  new guess
  """
  defp accept_move(%Game{guesses: guesses} = game, guess, _already_guessed = false) do
    # put new guess in guesses MapSet, then put mapset in game struct
    Map.put(game, :guesses, MapSet.put(guesses, guess))
    # check if guess is good/bad
    |> process_guess(Enum.member?(game.letters, guess))
  end

  @doc """
  good guess
  """
  defp process_guess(game, _hit = true) do
    # check if the target word is found in the list of guessed letters
    new_state =
      MapSet.new(game.letters)
      |> MapSet.subset?(game.guesses)
      |> check_if_won()

    Map.put(game, :game_state, new_state)

    # subtract 1 from turns_left
    # check if no turns remaining -> game lost
    # check if game won? Change game_status to :won,
    # game not won, change game_status to :good_guess
  end

  @doc """
  bad guess, and no turns remaining
  """
  defp process_guess(game = %Game{turns_left: 1}, _miss = false) do
    # subtract 1 from turns_left
    # check if game lost
    # change game_status to :bad_guess
    Map.put(game, :game_state, :lost)
  end

  @doc """
  bad guess, turns remaining
  """
  defp process_guess(game = %Game{turns_left: turns_left}, _miss = false) do
    # subtract 1 from turns_left
    %{game | game_state: :bad_guess, turns_left: turns_left - 1}
  end

  defp check_if_won(true) do
    :won
  end

  defp check_if_won(false) do
    :good_guess
  end

  defp reveal_guessed(letters, guesses) do
    letters
    |> Enum.map(fn letter -> reveal_letter(letter, MapSet.member?(guesses, letter)) end)
  end

  defp reveal_letter(letter, true) do
    letter
  end

  defp reveal_letter(_letter, false) do
    "_"
  end
end
