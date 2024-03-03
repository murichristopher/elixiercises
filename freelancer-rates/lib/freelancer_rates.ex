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
    |> scale_to_month()
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate
    |> daily_rate()
    |> apply_discount(discount)
    |> then(fn discounted_daily_rate ->
      Float.floor(budget / discounted_daily_rate, 1)
    end)
  end

  defp scale_to_month(daily_rate), do: @month_billable_days * daily_rate
end
