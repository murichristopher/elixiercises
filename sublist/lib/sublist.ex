defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a == b do
    :equal
  end

  def compare([], _b) do
    :sublist
  end

  def compare(_a, []) do
    :superlist
  end

  def compare(a, b) when length(a) > length(b) do
    if sublist?(b, a) do
      :superlist
    else
      :unequal
    end
  end

  def compare(a, b) do
    if sublist?(a, b) do
      :sublist
    else
      :unequal
    end
  end

  defp sublist?(a, b) do
    b
    |> Enum.chunk_every(length(a), 1, :discard)
    |> Enum.member?(a)
  end
end
