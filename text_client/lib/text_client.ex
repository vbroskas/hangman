defmodule TextClient do
  # API for text interface
  defdelegate start(), to: TextClient.Interact
end
