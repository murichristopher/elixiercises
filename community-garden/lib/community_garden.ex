# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ {[], 1}) do
    Agent.start(fn -> opts end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {registrations, _count} -> registrations end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn {registrations, count} ->
      new_plot = %Plot{
        registered_to: register_to,
        plot_id: count
      }

      {new_plot, {[new_plot | registrations], count + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn {registrations, count} ->
      new_registrations =
        Enum.reject(registrations, fn %Plot{} = registration ->
          registration.plot_id == plot_id
        end)

      {:ok, {new_registrations, count}}
    end)
  end

  def get_registration(pid, plot_id) do
    pid
    |> list_registrations()
    |> Enum.find(fn %Plot{} = registration -> registration.plot_id == plot_id end)
    |> case do
      %Plot{} = plot -> plot
      _ -> {:not_found, "plot is unregistered"}
    end
  end
end
