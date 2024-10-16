defmodule Username do
  @german_to_latin_char %{
    ?ä => [?e, ?a],
    ?ö => [?e, ?o],
    ?ü => [?e, ?u],
    ?ß => [?s, ?s]
  }

  def sanitize(username) do
    do_sanitize(username, [])
  end

  defp do_sanitize([head | tail], chars) do
    cond do
      head in ?a..?z or head == ?_ ->
        do_sanitize(tail, [head | chars])

      Map.has_key?(@german_to_latin_char, head) ->
        do_sanitize(tail, @german_to_latin_char[head] ++ chars)

      true ->
        do_sanitize(tail, chars)
    end
  end

  defp do_sanitize([], chars), do: Enum.reverse(chars)
end
