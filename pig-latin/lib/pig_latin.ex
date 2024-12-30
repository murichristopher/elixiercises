defmodule PigLatin do
  @moduledoc """
  Translates a given phrase to Pig Latin.
  """

  @vowels [?a, ?e, ?i, ?o, ?u]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()

  def translate(phrase) do
    phrase
    |> String.split(~r/\s+/)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(<<prefix, _rest::binary>> = str) when prefix in @vowels do
    str <> "ay"
  end

  defp translate_word(<<?x, ?r, _rest::binary>> = str) do
    str <> "ay"
  end

  defp translate_word(<<?y, ?t, _rest::binary>> = str) do
    str <> "ay"
  end

  defp translate_word(<<?q, ?u, rest::binary>>) do
    translate_word(rest <> <<?q, ?u>>)
  end

  defp translate_word(<<prefix, ?y, rest::binary>>) when prefix not in @vowels do
    "y" <> rest <> <<prefix>> <> "ay"
  end

  defp translate_word(<<prefix, rest::binary>>) when prefix not in @vowels do
    translate_word(rest <> <<prefix>>)
  end
end
