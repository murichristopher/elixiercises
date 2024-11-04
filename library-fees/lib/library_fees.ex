defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    cond do
      before_noon?(checkout_datetime) ->
        checkout_datetime
        |> NaiveDateTime.add(28, :day)
        |> NaiveDateTime.to_date()

      true ->
        NaiveDateTime.add(checkout_datetime, 29, :day)
        |> NaiveDateTime.to_date()
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_date = datetime_from_string(checkout)
    return_date = datetime_from_string(return)

    difference =
      checkout_date
      |> return_date()
      |> days_late(return_date)

    fee = difference * rate

    apply_monday_discount(fee, return_date)
  end

  defp apply_monday_discount(fee, return_date) do
    if monday?(return_date), do: trunc(fee * 0.5), else: fee
  end
end
