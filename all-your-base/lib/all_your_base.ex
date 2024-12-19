defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}

  def convert(_digits, input_base, _output_base) when input_base < 2 do
    {:error, "input base must be >= 2"}
  end

  def convert(_digits, _input_base, output_base) when output_base < 2 do
    {:error, "output base must be >= 2"}
  end

  def convert([], _input_base, _output_base), do: {:ok, [0]}

  def convert([0 | rest], input_base, output_base), do: convert(rest, input_base, output_base)

  def convert(digits, input_base, output_base) do
    if not valid_digits?(digits, input_base) do
      {:error, "all digits must be >= 0 and < input base"}
    else
      number = digits_to_decimal_number(digits, input_base)

      {:ok, decimal_to_base(number, output_base)}
    end
  end

  defp valid_digits?(digits, input_base) do
    Enum.all?(digits, fn digit -> digit >= 0 and digit < input_base end)
  end

  def digits_to_decimal_number(digits, input_base) do
    Enum.reduce(digits, 0, fn digit, acc -> acc * input_base + digit end)
  end

  defp decimal_to_base(decimal, base) do
    do_decimal_to_base([], decimal, base)
  end

  defp do_decimal_to_base(digits, 0, _base) do
    digits
  end

  defp do_decimal_to_base(digits, remaining, base) do
    do_decimal_to_base([rem(remaining, base) | digits], div(remaining, base), base)
  end
end
