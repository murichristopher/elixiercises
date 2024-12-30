defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @number_words %{
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten"
  }

  @spec recite(pos_integer, pos_integer) :: String.t()
  def recite(start_bottle, take_down) do
    verse(start_bottle) <> do_recite(start_bottle - 1, take_down - 1)
  end

  defp do_recite(_start, 0), do: ""

  defp do_recite(start, verse_count) do
    "\n\n" <> verse(start) <> do_recite(start - 1, verse_count - 1)
  end

  defp verse(number) do
    first_line =
      "#{String.capitalize(to_word(number))} green #{pluralize("bottle", number)} hanging on the wall,"

    """
    #{first_line}
    #{first_line}
    And if one green bottle should accidentally fall,
    There'll be #{to_word(number - 1)} green #{pluralize("bottle", number - 1)} hanging on the wall.\
    """
  end

  defp to_word(number) do
    Map.get(@number_words, number, "no")
  end

  defp pluralize(word, 1), do: word
  defp pluralize(word, _count), do: word <> "s"
end
