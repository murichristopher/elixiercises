defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.transform([], fn item, acc ->
      if prime?(item, acc) do
        {[item], Enum.sort([item | acc])}
      else
        {[], acc}
      end
    end)
    |> Enum.at(count - 1)
  end

  defp prime?(item, vector) do
    point = :math.sqrt(item)

    vector
    |> Enum.take_while(&(&1 <= point))
    |> Enum.all?(fn prime -> rem(item, prime) != 0 end)
  end
end
