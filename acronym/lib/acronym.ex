defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    regex = ~r/(?<=^|\s|-|_)[A-Za-z]/

    Regex.scan(regex, string)
    |> List.flatten()
    |> Enum.join()
    |> String.upcase()
  end
end
