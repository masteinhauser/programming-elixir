defmodule Sequence.Supervisor do
  use Supervisor.Behaviour

  def start_link(initial_number) do
    :supervisor.start_link(__MODULE__, initial_number)
  end

  def init(initial_number) do
    children = [
      # Define workers and child supervisors to be supervised
      worker(Sequence.Server, [initial_number])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end
end
