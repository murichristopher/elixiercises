defmodule LibraryFees do
  def datetime_from_string(string) do
    with {:ok, date} <- NaiveDateTime.from_iso8601(string) do
      date
    end
  end

  def before_noon?(%NaiveDateTime{} = datetime) do
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
    difference =
      NaiveDateTime.to_date(actual_return_datetime)
      |> Date.diff(planned_return_date)

    if difference < 1 do
      0
    else
      difference
    end
  end

  def monday?(datetime) do
    day_of_week =
      datetime
      |> NaiveDateTime.to_date()
      |> Date.day_of_week()

    day_of_week == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    {:ok, checkout_date, _} = DateTime.from_iso8601(checkout)
    {:ok, return_date, _} = DateTime.from_iso8601(return)

    checkout_naive_date = DateTime.to_naive(checkout_date)

    difference = days_late(checkout_naive_date, return_date)
    return_date_naive = return_date |> DateTime.to_naive()
    expected_return_date = return_date(checkout_naive_date)

    difference = Date.diff(return_date_naive, expected_return_date)

    if difference <= 0 do
      0
    else
      apply_monday_discount(difference * rate, return_date)
    end
  end

  defp apply_monday_discount(fee, return_date) do
    case monday?(return_date) do
      true ->
        trunc(fee * 0.5)

      _ ->
        fee
    end
  end
end
