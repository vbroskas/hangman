defmodule Procs do
  def call_center(number_of_calls \\ 0) do
    receive do
      {:kill, reason} ->
        exit(reason)

      {:a_call, value} ->
        IO.inspect("JUST GOT IN #{value} for call ##{number_of_calls}")
        call_center(number_of_calls + 1)

      {:reset} ->
        IO.puts("call counter rest")
        call_center(0)
    end
  end
end
