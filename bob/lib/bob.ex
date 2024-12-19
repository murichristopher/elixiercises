defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    cond do
      silence?(input) ->
        "Fine. Be that way!"

      shouting_question?(input) ->
        "Calm down, I know what I'm doing!"

      shouting?(input) ->
        "Whoa, chill out!"

      question?(input) ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp silence?(input) do
    input == ""
  end

  defp shouting_question?(input) do
    shouting?(input) && question?(input)
  end

  defp shouting?(input) do
    String.upcase(input) == input && String.downcase(input) != input
  end

  defp question?(input) do
    String.last(input) == "?"
  end
end
