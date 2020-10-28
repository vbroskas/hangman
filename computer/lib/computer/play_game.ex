defmodule Computer.PlayGame do
  @letters ~w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  @most_common Dictionary.get_most_common_8_letters()
  def start do
    game = Hangman.new_game()
    make_move(game, Enum.random(@letters))
  end

  def make_move(_game = %{game_state: state}, _guess) when state in [:won, :lost] do
    IO.puts("OVER...#{state}!")
  end

  def make_move(game, guess) do
    IO.puts("guessing..#{guess}")

    {ngs, tally} = Hangman.make_move(game, guess)
    IO.inspect("Turns left: #{ngs.turns_left}")
    IO.inspect("#{tally.display_letters}")
    IO.inspect("#{Enum.join(tally.letters_guessed, " ")}")
    make_move(ngs, Enum.random(@letters))
  end
end
