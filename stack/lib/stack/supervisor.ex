defmodule Stack.Supervisor do
  use Supervisor.Behaviour

  def start_link(stack) do
    :supervisor.start_link(__MODULE__, stack)
  end

  def init(stack) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Stack.Server, [stack])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
