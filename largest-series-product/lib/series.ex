defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer

  def largest_product("", size) when size >= 1, do: raise(ArgumentError)
  def largest_product(_number_string, size) when size < 0, do: raise(ArgumentError)

  def largest_product(number_string, size) do
    if size > String.length(number_string), do: raise(ArgumentError)

    String.to_integer(number_string)
    |> Integer.digits()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.reduce(0, &max_product/2)
  end

  defp max_product(list, acc) do
    list
    |> Enum.reduce(&*/2)
    |> max(acc)
  end
end
