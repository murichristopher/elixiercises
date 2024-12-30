defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
    |> Stream.flat_map(fn factor -> multiples_of(factor, limit) end)
    |> Stream.uniq()
    |> Enum.sum()
  end

  defp multiples_of(0, _limit) do
    []
  end

  defp multiples_of(number, limit) do
    Stream.iterate(number, &(&1 + number))
    |> Stream.take_while(&(&1 < limit))
    |> Enum.to_list()
  end
end
