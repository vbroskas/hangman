defmodule TextClient.Interact do
  alias TextClient.{Interact, State, Player}

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  def play(state) do
    # interact with player
    # ..each interaction changes state
    # at the end play will call itself play(state)
  end

  defp setup_state(game) do
    %State{game_service: game, tally: Hangman.tally(game)}
  end
end
