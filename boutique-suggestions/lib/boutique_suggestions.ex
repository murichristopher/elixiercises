defmodule BoutiqueSuggestions do
  @default_maximum_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    maximum_price = Keyword.get(options, :maximum_price, @default_maximum_price)

    for top <- tops,
        bottom <- bottoms,
        bottom[:base_color] != top[:base_color],
        bottom[:price] + top[:price] < maximum_price do
      {top, bottom}
    end
  end
end
