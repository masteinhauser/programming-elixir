defmodule Sequence.Server do
  use GenServer.Behaviour
  @vsn "1"

  # The state representation has been changed to a tuple throughout the module

  # External API
  def start_link(stash_pid) do
    :gen_server.start_link({ :local, :sequence }, __MODULE__, stash_pid, [])
  end

  def get_pid do
    :gen_server.call :sequence, :get_pid
  end

  def next_number do
    :gen_server.call :sequence, :next_number
  end

  def set_number(new_number) do
    :gen_server.call :sequence, {:set_number, new_number}
  end

  def increment_number(delta) do
    :gen_server.cast :sequence, {:increment_number, delta}
  end

  # GenServer implementation
  def init(stash_pid) do
    {current_number, delta} = Sequence.Stash.get_value stash_pid
    {:ok, {current_number, delta, stash_pid}}
  end

  def code_change("0", old_state, _extra) do
    IO.puts "Changing code from vsn 0 to 1"
    {:ok, {old_state, 1}}
  end

  def handle_call(:get_pid, _from, {current_number, delta, stash_pid}) do
    { :reply, stash_pid, {current_number, delta, stash_pid}}
  end

  def handle_call(:next_number, _from, {current_number, delta, stash_pid}) do
    { :reply, current_number, {current_number+delta, delta, stash_pid}}
  end

  def handle_call({:set_number, new_number}, _from, {_current_number, delta, stash_pid}) do
    { :reply, new_number, {new_number, delta, stash_pid} }
  end

  def handle_cast({:increment_number, delta}, {current_number, _old_delta, stash_pid}) do
    { :noreply, {current_number + delta, delta, stash_pid}}
  end
end
