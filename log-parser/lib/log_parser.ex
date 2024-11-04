defmodule LogParser do
  def valid_line?(line) do
    regex = ~r/^\[DEBUG\]|\[INFO\]|\[WARNING\]|\[ERROR\]/

    Regex.match?(regex, line)
  end

  def split_line(line) do
    dividers = ~r/<[<>=~*-]*?>/

    String.split(line, dividers)
  end

  def remove_artifacts(line) do
    dividers = ~r/(end-of-line[0-9]+)/i

    String.split(line, dividers)
    |> Enum.join()
  end

  def tag_with_user_name(line) do
    tag_with_user_regex = ~r/User[\s]+[^ ]*/

    case Regex.run(tag_with_user_regex, line) do
      [match] ->
        user_name =
          match
          |> String.split()
          |> Enum.at(1)

        "[USER] #{user_name} #{line}"

      nil ->
        line
    end
  end
end
