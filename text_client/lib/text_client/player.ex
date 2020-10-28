defmodule TextClient.Player do
  alias TextClient.{Move, Prompter, State, Summary}

  # won, lost, good_guess, bad_guess, already_used, initialized
  def play(%State{tally: %{game_state: :won}}) do
    exit_with_msg("won")
  end

  def play(%State{tally: %{game_state: :lost}}) do
    exit_with_msg("LOST")
  end

  def play(game = %State{tally: %{game_state: :good_guess}}) do
    continue_with_msg(game, "good guess")
  end

  def play(game = %State{tally: %{game_state: :bad_guess}}) do
    continue_with_msg(game, "bad guess")
  end

  def play(game = %State{tally: %{game_state: :already_used}}) do
    continue_with_msg(game, "Already guessed that letter!")
  end

  def play(game = %State{tally: %{game_state: :initializing}}) do
    continue_with_msg(game, "Lets begin!")
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Move.make_move()
    |> play()
  end

  defp exit_with_msg(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  defp continue_with_msg(game, msg) do
    IO.puts(msg)
    continue(game)
  end
end
