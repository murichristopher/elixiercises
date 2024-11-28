defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    regex = ~r/(.)\1*/

    Regex.scan(regex, string)
    |> Enum.map_join(fn [match, char] ->
      letter_times_repeat = String.length(match)

      cond do
        letter_times_repeat > 1 ->
          "#{letter_times_repeat}#{char}"

        true ->
          char
      end
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    regex = ~r/\d*(.)\1*/

    Regex.scan(regex, string)
    |> Enum.map_join(fn [match, _char] ->
      case Regex.run(~r/^(\d*)([A-Za-z])$/, match) do
        [_, "", letter] ->
          letter

        [_, letter_times, letter] ->
          String.duplicate(letter, String.to_integer(letter_times))

        _any ->
          case String.split(match, "", trim: true) do
            [letter] -> letter
            [letter_times, letter] -> String.duplicate(letter, String.to_integer(letter_times))
          end
      end
    end)
  end
end
