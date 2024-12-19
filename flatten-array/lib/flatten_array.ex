defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1, 2, 3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> do_flatten([])
  end

  defp do_flatten([], acc) do
    acc
  end
  
  defp do_flatten(item, _acc) when not is_list(item) do
    [item]
  end

  defp do_flatten([nil | tail], acc) do
    do_flatten(tail, acc)
  end

  defp do_flatten([head | tail], acc) do
    do_flatten(tail, acc ++ do_flatten(head, []))
  end
end
