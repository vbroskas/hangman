defmodule Computer do
  defdelegate start(), to: Computer.PlayGame
end
