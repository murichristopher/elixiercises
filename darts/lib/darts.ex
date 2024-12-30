defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    radius = :math.sqrt(x * x + y * y)

    cond do
      radius <= 1 -> 10
      radius <= 5 -> 5
      radius <= 10 -> 1
      true -> 0
    end
  end
end
