defmodule Formz.Session do
  use GenServer

  @timeout :timer.minutes(20)

  def start_link(name) do
    GenServer.start_link(__MODULE__, {:ok}, name: via(name))
  end

  defp via(name), do: Formz.Registry.via(name)

  @impl GenServer
  def init({:ok}) do
    state = Formz.UserForm.new()

    {:ok, state, @timeout}
  end

  def session_pid(name) do
    name
    |> via()
    |> GenServer.whereis()
  end

  def session_state(name) do
    GenServer.call(via(name), {:session_state})
  end

  @impl GenServer
  def handle_call({:session_state}, _from, state) do
    {:reply, state, state, @timeout}
  end

  @impl GenServer
  def handle_info(:timeout, session) do
    {:stop, {:shutdown, :timeout}, session}
  end

  @impl GenServer
  def terminate(_reason, _session) do
    :ok
  end

  def session_name do
    Registry.keys(Formz.Registry, self()) |> List.first()
  end
end
