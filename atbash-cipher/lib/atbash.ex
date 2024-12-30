defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.to_charlist()
    |> Stream.flat_map(&atbash_letter/1)
    |> Stream.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.to_charlist()
    |> Stream.flat_map(&atbash_letter/1)
    |> Enum.to_list()
    |> List.to_string()
  end

  defp atbash_letter(char) when char in ?a..?z do
    [219 - char]
  end

  defp atbash_letter(char) when char in ?0..?9 do
    [char]
  end

  defp atbash_letter(_char) do
    []
  end
end
