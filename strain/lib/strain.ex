defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)

  def keep(item, fun) do
    do_keep([], item, fun)
  end

  defp do_keep(acc, [item | rest], fun) do
    if fun.(item) do
      do_keep(acc ++ [item], rest, fun)
    else
      do_keep(acc, rest, fun)
    end
  end

  defp do_keep(acc, [], _fun), do: acc

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    do_keep([], list, fn item -> not fun.(item) end)
  end
end
