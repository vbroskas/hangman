defmodule TextClient.Prompter do
  def accept_move(game) do
    IO.gets("> Guess a letter: ")
    |> process_input(game)
    |> IO.inspect()
  end

  defp process_input(:eof, game) do
    IO.puts("Sorry there was an error with your input, try again...")
    accept_move(game)
  end

  defp process_input({:error, _reason}, game) do
    IO.puts("Sorry there was an error with your input, try again...")
    accept_move(game)
  end

  defp process_input(input, game) do
    input
    |> String.replace(~r/[^[:alpha:]]/, "")
    |> String.trim()
    |> String.downcase()
    |> vet_input(game)
  end

  defp vet_input(input, game) do
    cond do
      String.length(input) == 0 ->
        IO.puts("Gotta type something...")
        accept_move(game)

      String.length(input) > 1 ->
        IO.puts("Just one letter please")
        accept_move(game)

      true ->
        input
    end
  end
end
