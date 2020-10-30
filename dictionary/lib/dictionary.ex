defmodule Dictionary do
  alias Dictionary.WordCache

  defdelegate read_word_list(), to: WordCache
  defdelegate get_random_word(word_list), to: WordCache

  defdelegate get_most_common_8_letters, to: WordCache
end
