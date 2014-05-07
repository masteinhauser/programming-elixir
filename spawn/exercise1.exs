import :timer, only: [ sleep: 1 ]

defmodule Exercise1 do
  def receive_message do
    receive do
      {sender, msg} ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
        receive_message
    end
  end

  def sad_method(parent) do
    send parent, "Hello #{inspect parent}"
    exit(99)
  end

  def run do
    res = Process.spawn_link(Exercise1, :sad_method, [self])
    IO.puts inspect res
    sleep 500
    receive_message
  end
end
