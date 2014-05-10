defmodule Sequence.Supervisor do
  use Supervisor.Behaviour

  def start_link({initial_number, initial_delta}) do
    result = {:ok, sup} = :supervisor.start_link(__MODULE__, [{initial_number, initial_delta}])
    start_workers(sup, {initial_number, initial_delta})
    result
  end

  def start_workers(sup, {initial_number, initial_delta}) do
    # Start the stash worker
    {:ok, stash_pid} = :supervisor.start_child(sup, worker(Sequence.Stash, [{initial_number, initial_delta}]))

    # and then the supervisor for the actual sequence server
    :supervisor.start_child(sup, supervisor(Sequence.SubSupervisor, [stash_pid]))
  end

  def init(_) do
    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise [], strategy: :one_for_one
  end
end
