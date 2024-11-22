defmodule TakeANumberDeluxe do
  use GenServer
  alias TakeANumberDeluxe.State
  alias TakeANumberDeluxe.Queue
  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  @impl GenServer
  def init(opts) do
    with {:ok, min_number} <- Keyword.fetch(opts, :min_number),
         {:ok, max_number} <- Keyword.fetch(opts, :max_number),
         shutdown <- Keyword.get(opts, :auto_shutdown_timeout, :infinity),
         {:ok, state} <- State.new(min_number, max_number, shutdown) do
      {:ok, state, shutdown}
    else
      _ -> {:stop, :invalid_configuration}
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    case State.queue_new_number(state) do
      {:ok, new_number, state} ->
        {:reply, {:ok, new_number}, state, state.auto_shutdown_timeout}

      {:error, reason} ->
        {:reply, {:error, reason}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, state} ->
        {:reply, {:ok, next_number}, state, state.auto_shutdown_timeout}

      {:error, reason} ->
        {:reply, {:error, reason}, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    new_state = %{state | queue: Queue.new()}

    {:noreply, new_state, new_state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end


  @impl GenServer
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
