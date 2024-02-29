defmodule FreelancerRates do
  @hours_per_workday 8
  @month_billable_days 22

  def daily_rate(hourly_rate), do: @hours_per_workday * (hourly_rate / 1)

  def apply_discount(before_discount, discount),
    do: before_discount - before_discount * (discount / 100)

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> apply_discount(discount)
    |> monthly_rate
    |> ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate(hourly_rate)
    |> apply_discount(discount)
    |> days_in_budget(budget)
    |> Float.floor(1)
  end

  defp monthly_rate(hourly_rate), do: @hours_per_workday * @month_billable_days * hourly_rate

  defp days_in_budget(rate, budget), do: budget / rate
end
