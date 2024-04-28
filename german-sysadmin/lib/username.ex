defmodule Username do
  @german_to_latin_char %{
    ?ä => [?a, ?e],
    ?ö => [?o, ?e],
    ?ü => [?u, ?e],
    ?ß => [?s, ?s]
  }
  @german_chars Map.keys(@german_to_latin_char)

  @alphabetic_chars_unicode ?a..?z
  @allowed_chars Enum.to_list(@alphabetic_chars_unicode) ++ [?_]

  def sanitize(username) do
    do_sanitize(username, ~c"")
  end

  defp do_sanitize([head | tail], chars) do
    case head do
      head when head in @allowed_chars ->
        do_sanitize(tail, chars ++ [head])

      head when head in @german_chars ->
        do_sanitize(tail, chars ++ @german_to_latin_char[head])

      _ ->
        do_sanitize(tail, chars)
    end
  end

  defp do_sanitize([], chars), do: chars
end
