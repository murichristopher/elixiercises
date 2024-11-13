defmodule DNA do
  def encode_nucleotide(?\s), do: 0b0000
  def encode_nucleotide(?A), do: 0b0001
  def encode_nucleotide(?C), do: 0b0010
  def encode_nucleotide(?G), do: 0b0100
  def encode_nucleotide(?T), do: 0b1000

  def decode_nucleotide(0b0000), do: ?\s
  def decode_nucleotide(0b0001), do: ?A
  def decode_nucleotide(0b0010), do: ?C
  def decode_nucleotide(0b0100), do: ?G
  def decode_nucleotide(0b1000), do: ?T

  def encode(list) do
    do_encode(list, <<>>)
  end

  def decode(dna) do
    do_decode(dna, [])
  end

  defp do_encode([head, head2 | tail], count) do
    encoded_pair = <<encode_nucleotide(head)::size(4), encode_nucleotide(head2)::size(4)>>

    do_encode(tail, <<count::binary, encoded_pair::binary>>)
  end

  defp do_encode([head | tail], count) do
    do_encode(tail, <<count::binary, encode_nucleotide(head)::size(4)>>)
  end

  defp do_encode([], count) do
    count
  end

  defp do_decode(<<encoded_nucleotide::size(4), rest::bitstring>>, count) do
    do_decode(rest, [decode_nucleotide(encoded_nucleotide) | count])
  end

  defp do_decode(<<>>, count) do
    reverse(count)
  end

  defp reverse(count) do
    do_reverse(count, [])
  end

  defp do_reverse([head | tail], acc) do
    do_reverse(tail, [head | acc])
  end

  defp do_reverse([], acc) do
    acc
  end
end
