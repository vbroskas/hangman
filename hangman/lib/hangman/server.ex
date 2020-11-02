defmodule Hangman.Server do
  use GenServer
  alias Hangman

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, Hangman.new_game()}
  end

  def make_move(pid, guess) do
    GenServer.call(pid, {:make_move, guess})
  end

  def handle_call({:make_move, guess}, _from, game) do
    {new_game, tally} = Hangman.make_move(game, guess)
    {:reply, tally, new_game}
  end
end
