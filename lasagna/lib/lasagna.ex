defmodule Lasagna do
  @expected_minutes_in_oven 40

  def expected_minutes_in_oven, do: @expected_minutes_in_oven

  def remaining_minutes_in_oven(num) do
    expected_minutes_in_oven() - num
  end

  def preparation_time_in_minutes(layers), do: layers * 2

  def total_time_in_minutes(layers, minutes_past_in_oven) do
    preparation_time_in_minutes(layers) + minutes_past_in_oven
  end

  def alarm, do: "Ding!"
end
