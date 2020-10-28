defmodule Dictionary do
  def random_word() do
    Enum.random(word_list())
  end

  def word_list() do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Enum.to_list()
    |> Enum.map(fn x -> String.replace(x, "\n", "") end)
  end

  def switch({a, b}) do
    {b, a}
  end

  def check(a, a) do
    true
  end

  def check(a, b) do
    false
  end

  def get_most_common_8_letters() do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Stream.flat_map(&String.split/1)
    |> Stream.flat_map(&String.graphemes/1)
    |> Enum.reduce(%{}, fn letter, acc ->
      Map.update(acc, letter, 1, fn current_value -> current_value + 1 end)
    end)
    |> Enum.sort_by(fn {_k, v} -> -v end)
    |> Enum.take(8)
    |> Enum.reduce([], fn {k, _v}, acc -> [k | acc] end)
  end
end
