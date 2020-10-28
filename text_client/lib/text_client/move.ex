defmodule TextClient.Move do
  alias TextClient.State

  def make_move(game = %State{guess: guess}) do
    {new_game_state, tally} = Hangman.make_move(game.game_service, guess)
    %State{game | game_service: new_game_state, tally: tally}
  end
end
