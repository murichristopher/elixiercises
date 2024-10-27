defmodule TakeANumber do
  def start(initial_state \\ 0) do
    spawn(fn ->
      listen(initial_state)
    end)
  end

  defp listen(state) do
    receive do
      {:report_state, caller} ->
        send(caller, state)
        listen(state)

      {:take_a_number, caller} ->
        new_state = state + 1
        send(caller, new_state)
        listen(new_state)

      :stop ->
        nil

      _ ->
        listen(state)
    end
  end
end
