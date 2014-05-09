defmodule Stack.Server do
  use GenServer.Behaviour

  # External API
  def start_link(stack) do
    :gen_server.start_link({ :local, :stack }, __MODULE__, stack, [])
  end

  def pop do
    :gen_server.call(:stack, :pop)
  end

  def push(frame) do
    :gen_server.call(:stack, {:push, frame})
  end

  # GenServer Implementation
  def init(stack)
  when is_list(stack) do
     {:ok, stack}
  end

  def terminate(reason, state) do
    IO.puts """
    Received call to terminate.
    Reason: #{reason}
    Current State: #{state}
    """
  end

  def handle_call(:pop, _from, stack) do
    [head | tail] = stack
    { :reply, head, tail }
  end

  def handle_call({:push, frame}, _from, stack) do
    stack = [ frame | stack]
    { :reply, stack, stack }
  end
end
