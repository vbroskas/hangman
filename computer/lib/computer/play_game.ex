defmodule Computer.PlayGame do
  # @letters ~w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  # @most_common Dictionary.get_most_common_8_letters()
  def start do
    game = Hangman.new_game()
    word_length = length(game.letters)
    guess_set = Dictionary.WordCache.get_letters_for_word_length(word_length)
    IO.inspect("-----------#{guess_set}----#{word_length}")
    make_move(game, Enum.random(guess_set), guess_set)
  end

  def make_move(_game = %{game_state: state}, _guess, _guess_set) when state in [:won, :lost] do
    IO.puts("OVER...#{state}!")
  end

  def make_move(game, guess, guess_set) do
    IO.puts("guessing..#{guess}")

    guess_set = update_guess_set(guess_set, guess)

    {ngs, tally} = Hangman.make_move(game, guess)
    IO.inspect("Turns left: #{ngs.turns_left}")
    IO.inspect("#{tally.display_letters}")
    IO.inspect("#{Enum.join(tally.letters_guessed, " ")}")
    # TODO Enum error if the computer tries all letters in guess_set before game ends!
    make_move(ngs, Enum.random(guess_set), guess_set)
  end

  defp update_guess_set(guess_set, guess) do
    Enum.reject(guess_set, fn letter -> letter == guess end)
  end
end
