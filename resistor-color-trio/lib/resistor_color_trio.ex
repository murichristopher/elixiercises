defmodule ResistorColorTrio do
  @doc """
  Calculate the resistance value in ohms from resistor colors
  """

  @color_bands %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }
  @units %{
    ohms: 1,
    kiloohms: 10 ** 3,
    megaohms: 10 ** 6,
    gigaohms: 10 ** 9
  }
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors
    |> colors_to_digits()
    |> calculate_resistance_value()
    |> format_with_unit()
  end

  defp format_with_unit(value) do
    unit = unit(value)

    {value / @units[unit], unit}
  end

  def colors_to_digits(colors) do
    Enum.map(colors, &@color_bands[&1])
  end

  def calculate_resistance_value([c1, c2, c3 | _]) do
    Integer.undigits([c1, c2 | List.duplicate(0, c3)])
  end

  defp unit(resistance) when resistance >= @units.gigaohms, do: :gigaohms
  defp unit(resistance) when resistance >= @units.megaohms, do: :megaohms
  defp unit(resistance) when resistance >= @units.kiloohms, do: :kiloohms
  defp unit(_), do: :ohms
end
