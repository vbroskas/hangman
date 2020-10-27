defmodule GameTest do
  use ExUnit.Case
  doctest Hangman.Game
  alias Hangman.Game

  test "new_game returns struct" do
    game = Game.new_game()
    assert game.turns_left == 5
    assert game.game_state == :initializing
    assert length(game.letters) > 1

    Enum.map(game.letters, fn x ->
      assert x == String.downcase(x)
    end)

    Enum.map(game.letters, fn x ->
      assert String.match?(x, ~r/[a-z]/) == true
    end)
  end

  test "state isnt changed for :won or game" do
    for state <- [:won, :lost] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, "x")
    end
  end

  test "first time letter guessed" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "letter already guessed" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "process correct guess" do
    game = Game.new_game_with_word("book")
    game = Game.make_move(game, "b")
    assert game.game_state == :good_guess
  end

  test "guess entire word" do
    game = Game.new_game_with_word("fan")
    game = Game.make_move(game, "f")
    game = Game.make_move(game, "o")
    game = Game.make_move(game, "a")
    game = Game.make_move(game, "n")
    assert game.game_state == :won
  end

  test "process bad guess" do
    game = Game.new_game_with_word("book")
    game = Game.make_move(game, "z")
    assert game.game_state == :bad_guess
    assert game.turns_left == 4
  end

  test "game ends after bad guess" do
    moves = [
      {"w", :bad_guess},
      {"z", :bad_guess},
      {"y", :bad_guess},
      {"l", :bad_guess},
      {"e", :lost}
    ]

    game = Game.new_game_with_word("book")

    Enum.reduce(moves, game, fn {guess, state}, acc ->
      game = Game.make_move(acc, guess)
      assert game.game_state == state
      game
    end)
  end
end
