defmodule TextClient.Summary do
  def display(game = %{tally: tally}) do
    IO.puts([
      "\n",
      "Words so far: #{Enum.join(tally.display_letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Letters guessed: #{Enum.join(tally.letters_guessed, " ")}\n"
    ])

    game
  end
end
