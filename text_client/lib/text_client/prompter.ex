defmodule TextClient.Prompter do
  alias TextClient.State

  def accept_move(game = %State{}) do
    response = IO.gets("> Guess a letter: ")
    process_input(response, game)
  end

  defp process_input(:eof, _game) do
    IO.puts("Sorry there was an error with your input, try again...")
    exit(:normal)
  end

  defp process_input({:error, _reason}, _game) do
    IO.puts("Sorry there was an error with your input, try again...")
    exit(:normal)
  end

  defp process_input(input, game = %State{}) do
    input
    |> String.replace(~r/[^[:alpha:]]/, "")
    |> String.trim()
    |> String.downcase()
    |> vet_input(game)
  end

  defp vet_input(input, game = %State{}) do
    cond do
      String.length(input) == 0 ->
        IO.puts("Gotta type something...")
        accept_move(game)

      String.length(input) > 1 ->
        IO.puts("Enter one letter please")
        accept_move(game)

      true ->
        %{game | guess: input}
    end
  end
end
