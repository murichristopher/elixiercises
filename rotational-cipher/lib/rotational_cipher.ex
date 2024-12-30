defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.graphemes()
    |> Enum.map_join(&do_rotate(&1, shift))
  end

  defp do_rotate(<<char::utf8>>, shift) when char in ?A..?Z do
    rotate_char(char, ?A, shift)
  end

  defp do_rotate(<<char::utf8>>, shift) when char in ?a..?z do
    rotate_char(char, ?a, shift)
  end

  defp do_rotate(char, _shift), do: char

  defp rotate_char(char, base, shift) do
    letter_index = char - base

    rotated_index = rem(letter_index + shift, 26)

    rotated_char = base + rotated_index

    <<rotated_char::utf8>>
  end
end
