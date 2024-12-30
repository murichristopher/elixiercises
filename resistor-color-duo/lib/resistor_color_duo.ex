defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
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

  @spec value(colors :: [atom]) :: integer
  def value([first_color, second_color | _rest_colors]) do
    Integer.undigits([@color_bands[first_color], @color_bands[second_color]])
  end
end
