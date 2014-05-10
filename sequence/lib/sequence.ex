defmodule Sequence do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, {initial_number, initial_delta}) do
    Sequence.Supervisor.start_link {initial_number, initial_delta}
  end
end
