defmodule Sequence.Stash do
  use GenServer.Behaviour

  # External API
  def start_link({initial_number, initial_delta}) do
    :gen_server.start_link(__MODULE__, {initial_number, initial_delta}, [])
  end

  def save(pid, {value, delta}) do
    :gen_server.cast pid, {:save_value, {value, delta}}
  end

  def save_value(pid, delta) do
    :gen_server.cast pid, {:save_delta, delta}
  end

  def save_value(pid, value) do
    :gen_server.cast pid, {:save_value, value}
  end

  def get_value(pid) do
    :gen_server.call pid, :get_value
  end

  # GenServer Implementation
  def init({initial_number, initial_delta})
  when is_number(initial_number) and is_number(initial_delta) do
    {:ok, {initial_number, initial_delta}}
  end

  def handle_call(:get_value, _from, {current_value, current_delta}) do
    {:reply, {current_value, current_delta}, {current_value, current_delta}}
  end

  def handle_cast({:save, {value, delta}}, {_current_value, _current_delta}) do
    {:noreply, {value, delta}}
  end

  def handle_cast({:save_delta, delta}, {current_value, _current_delta}) do
    {:noreply, {current_value, delta}}
  end

  def handle_cast({:save_value, value}, {_current_value, current_delta}) do
    {:noreply, {value, current_delta}}
  end
end
