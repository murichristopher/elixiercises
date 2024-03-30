defmodule BirdCount do
  def today([head | _tail]), do: head
  def today([]), do: nil

  def increment_day_count([head | tail]), do: [head + 1 | tail]
  def increment_day_count([]), do: [1]

  def has_day_without_birds?([0 | _tail]), do: true
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([_head | tail]), do: has_day_without_birds?(tail)

  def total(list), do: do_total(0, list)
  defp do_total(acc, []), do: acc
  defp do_total(acc, [head | tail]), do: do_total(acc + head, tail)

  def busy_days(list), do: do_busy_days(0, list)
  defp do_busy_days(acc, [head | tail] = list) when head >= 5, do: do_busy_days(acc + 1, tail)
  defp do_busy_days(acc, [head | tail]), do: do_busy_days(acc, tail)
  defp do_busy_days(acc, []), do: acc
end
