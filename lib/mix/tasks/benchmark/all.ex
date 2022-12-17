defmodule Mix.Tasks.Benchmark.All do
  @moduledoc """
  Task to benchmark different implementations of an algorithm.
  The different implementations will be run and the running times
  will be reported in stdout.
  """
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Mix.Tasks.Benchmark.drivers()
    |> Enum.each(& &1.())
  end
end
