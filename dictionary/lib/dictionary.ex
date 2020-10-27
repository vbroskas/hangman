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
end
