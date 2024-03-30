defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found

  def search(numbers, key) do
    do_search({0, tuple_size(numbers) - 1}, numbers, key)
  end

  defp do_search({startc, endc}, numbers, key) do
    mid_index = div(startc + endc, 2)
    mid_value = elem(numbers, mid_index)

    do_search({startc, endc}, {mid_index, mid_value}, numbers, key)
  end

  defp do_search(_cordinates, {mid_index, mid_val}, _numbers, key) when mid_val == key,
    do: {:ok, mid_index}

  defp do_search(_cordinates, {0, _val}, _numbers, _key),
    do: :not_found

  defp do_search({_startc, endc}, {mid_index, _val}, _numbers, _key) when mid_index == endc,
    do: :not_found

  defp do_search({startc, _endc}, {mid_index, mid_val}, numbers, key) when mid_val > key,
    do: do_search({startc, mid_index - 1}, numbers, key)

  defp do_search({_startc, endc}, {mid_index, mid_val}, numbers, key) when mid_val < key,
    do: do_search({mid_index + 1, endc}, numbers, key)
end
