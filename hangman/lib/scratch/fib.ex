defmodule Fib do
  def start_link() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: __MODULE__)
  end

  def update(n, result) do
    Agent.update(__MODULE__, fn state -> Map.put(state, n, result) end)
  end

  def get_num(n) do
    map = Agent.get(__MODULE__, & &1)
    Map.get(map, n)
  end

  def fib(_n = 0) do
    0
  end

  def fib(_n = 1) do
    1
  end

  def fib(n) when n > 1 do
    # check if n in agent map
    case get_num(n) do
      nil ->
        # make recursive call
        result = fib(n - 1) + fib(n - 2)
        # update agent map
        update(n, result)
        result

      result ->
        result
    end
  end
end
