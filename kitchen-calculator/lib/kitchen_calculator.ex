defmodule KitchenCalculator do
  def get_volume({_unit, volume}), do: volume

  def to_milliliter({unit, volume}) do
    unit
    |> fetch_conversion_factor()
    |> then(fn conversion_factor -> {:milliliter, conversion_factor * volume} end)
  end

  def from_milliliter({_from_unit, from_volume}, to_unit) do
    to_unit
    |> fetch_conversion_factor()
    |> then(fn conversion_factor -> {to_unit, from_volume / conversion_factor} end)
  end

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end

  defp fetch_conversion_factor(unit) do
    case unit do
      :cup -> 240
      :fluid_ounce -> 30
      :teaspoon -> 5
      :tablespoon -> 15
      :milliliter -> 1
    end
  end
end
