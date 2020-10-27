defmodule TextClient.Summary do
  def display(%{tally: tally}) do
    IO.puts([
      "\n",
      "Words so far: #{Enum.join(tally.display_letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n"
    ])
  end
end
