# Write a list comprehension that finds all the Pythagorean triples for right triangles with sides shorter than 100. A Pythagorean triple is three integers a^2 + b^2 == c^2

defmodule Scratch do
  def test1 do
    :timer.tc(fn ->
      for a <- 1..100, b <- 1..100, c <- 1..100, a * a + b * b == c * c, do: {a, b, c}
      :ok
    end)
  end

  def test2 do
    :timer.tc(fn ->
      for a <- 1..100,
          b <- 1..100,
          c <- 1..100,
          c > a,
          c > b,
          a * a + b * b == c * c,
          do: {a, b, c}

      :ok
    end)
  end

  def test3 do
    :timer.tc(fn ->
      for a <- 1..100,
          b <- 1..100,
          c <- 1..100,
          c < a + b,
          a * a + b * b == c * c,
          do: {a, b, c}

      :ok
    end)
  end
end
