defmodule Dictionary.WordCache do
  use Agent

  def start_link() do
    Agent.start_link(fn -> read_word_list() end, name: __MODULE__)
  end

  def get_random_word() do
    Agent.get(__MODULE__, &Enum.random/1)
  end

  def read_word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Enum.to_list()
    |> Enum.map(fn x -> String.replace(x, "\n", "") end)
  end

  def get_most_common_8_letters() do
    "../../assets/words.txt"
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

  def get_letters_for_word_length(length) do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.stream!()
    |> Stream.flat_map(&String.split/1)
    |> Enum.reject(fn word -> String.length(word) != length end)
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.reduce(%{}, fn letter, acc ->
      Map.update(acc, letter, 1, fn current_value -> current_value + 1 end)
    end)
    |> Enum.sort_by(fn {_k, v} -> -v end)

    # TODO what should I use to calc this...
    # |> Enum.take(length + 4)
    # |> Enum.reduce([], fn {k, _v}, acc -> [k | acc] end)
  end
end
