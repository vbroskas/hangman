defmodule Hangman.Server do
  use GenServer
  alias Hangman.Game

  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  def init(_) do
    {:ok, Game.new_game()}
  end

  def make_move(pid, guess) do
    GenServer.call(pid, {:make_move, guess})
  end

  def handle_call({:make_move, guess}, _from, game) do
    {new_game, tally} = Game.make_move(game, guess)
    {:reply, tally, new_game}
  end

  def handle_call({:get_tally}, _from, game) do
    tally = Game.tally(game)
    {:reply, tally, game}
  end
end
