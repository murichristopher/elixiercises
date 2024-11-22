defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    preffix = "NCC-"
    suffix = Enum.random(1000..9999)

    preffix <> to_string(suffix)
  end

  def random_stardate() do
    season_end = 42000.0
    season_start = 41000.0
    :rand.uniform() * (season_end - season_start) + season_start
  end

  def format_stardate(stardate) do
    "~.1f"
    |> :io_lib.format([stardate])
    |> to_string()
  end
end
