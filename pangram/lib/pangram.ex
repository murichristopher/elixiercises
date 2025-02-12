defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence_charlist =
      sentence
      |> String.downcase()
      |> String.to_charlist()

    ?a..?z
    |> Enum.to_list()
    |> Enum.all?(fn char -> char in sentence_charlist end)
  end
end
