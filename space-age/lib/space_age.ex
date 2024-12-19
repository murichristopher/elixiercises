defmodule SpaceAge do
  @type planet ::
          :mercury
          | :venus
          | :earth
          | :mars
          | :jupiter
          | :saturn
          | :uranus
          | :neptune

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet', or an error if 'planet' is not a planet.
  """
  @spec age_on(planet, pos_integer) :: {:ok, float} | {:error, String.t()}
  def age_on(:earth, seconds) do
    calculate_planet_age(seconds, 1.0)
  end

  def age_on(:mercury, seconds) do
    calculate_planet_age(seconds, 0.2408467)
  end

  def age_on(:venus, seconds) do
    calculate_planet_age(seconds, 0.61519726)
  end

  def age_on(:mars, seconds) do
    calculate_planet_age(seconds, 1.8808158)
  end

  def age_on(:jupiter, seconds) do
    calculate_planet_age(seconds, 11.862615)
  end

  def age_on(:saturn, seconds) do
    calculate_planet_age(seconds, 29.447498)
  end

  def age_on(:uranus, seconds) do
    calculate_planet_age(seconds, 84.016846)
  end

  def age_on(:neptune, seconds) do
    calculate_planet_age(seconds, 164.79132)
  end

  def age_on(_planet, _seconds) do
    {:error, "not a planet"}
  end

  defp calculate_planet_age(seconds, scale) do
    {:ok, age_on_earth(seconds) / scale}
  end

  defp age_on_earth(seconds) do
    seconds / 31_557_600
  end
end
