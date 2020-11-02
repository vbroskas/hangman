defmodule Dictionary do
  alias Dictionary.WordCache

  defdelegate get_random_word(), to: WordCache

  defdelegate get_most_common_8_letters, to: WordCache
end
