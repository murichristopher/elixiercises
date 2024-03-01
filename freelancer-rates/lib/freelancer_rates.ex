defmodule FreelancerRates do
  @hours_per_workday 8.0
  @month_billable_days 22

  def daily_rate(hourly_rate), do: @hours_per_workday * hourly_rate

  def apply_discount(before_discount, discount),
    do: before_discount - before_discount * (discount / 100)

  def monthly_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> apply_discount(discount)
    |> then(&(@month_billable_days * &1))
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_rate(hourly_rate)
    |> apply_discount(discount)
    |> then(&(budget / &1))
    |> Float.floor(1)
  end
end
