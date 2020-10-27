defmodule Dictionary.Lists do
  def map([], _) do
    []
  end

  def map([head | tail], func) do
    [func.(head) | map(tail, func)]
  end

  def len([]) do
    0
  end

  def len([h | t]) do
    1 + len(t)
  end

  def sum([]) do
    0
  end

  def sum([h | t]) do
    h + sum(t)
  end

  def double([]) do
    []
  end

  def double([h | t]) do
    [h * 2 | double(t)]
  end

  def halve([]) do
    []
  end

  def halve([h1, h2 | t]) do
    [h1 + h2 | halve(t)]
  end

  def halve([h1 | t]) do
    [h1 | halve(t)]
  end

  def check?([]) do
    true
  end

  def check?([_h | []]) do
    false
  end

  def check?([_i1, _i2 | tail]) do
    check?(tail)
  end
end
