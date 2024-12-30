defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, &anagram?(base, &1))
  end

  defp anagram?(candidate, base) do
    {normalize(candidate), normalize(base)}
    |> case do
      {candidate, base}
      when candidate == base ->
        false

      {candidate, base} ->
        Enum.sort(candidate) == Enum.sort(base)
    end
  end

  defp normalize(term) do
    term
    |> String.downcase()
    |> String.graphemes()
  end
end
