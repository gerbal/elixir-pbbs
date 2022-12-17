defmodule Mix.Tasks.Benchmark do
  @moduledoc """
    Task to benchmark different implementations of an algorithm.
    The different implementations will be run and the running times
    will be reported in stdout.

    Parameters:
    --algorithm (-a) - the algorithm to benchmark (required)
    --runtime (-t) - how long to run each sub-benchmark in seconds. Defaults to 60
  """

  use Mix.Task

  @impl Mix.Task
  def run(args) do
    parsed_args =
      OptionParser.parse(args,
        aliases: [
          a: :algorithm,
          t: :runtime
        ],
        strict: [
          algorithm: :string,
          runtime: :integer
        ]
      )

    parsed = elem(parsed_args, 0)

    algorithm = Keyword.get(parsed, :algorithm)
    time = Keyword.get(parsed, :runtime, 60)

    if algorithm == nil do
      usage()
    else
      execute(algorithm, time)
    end
  end

  def drivers do
    %{
      "histogram" => &Utils.Benchmark.Drivers.Histogram.run_benchmark/1,
      "word_count" => &Utils.Benchmark.Drivers.WordCount.run_benchmark/1,
      "remove_duplicates" => &Utils.Benchmark.Drivers.RemoveDuplicates.run_benchmark/1,
      "ray_cast" => &Utils.Benchmark.Drivers.RayCast.run_benchmark/1,
      "convex_hull" => &Utils.Benchmark.Drivers.ConvexHull.run_benchmark/1,
      "suffix_array" => &Utils.Benchmark.Drivers.SuffixArray.run_benchmark/1,
      "integer_sort" => &Utils.Benchmark.Drivers.IntegerSort.run_benchmark/1,
      "comparison_sort" => &Utils.Benchmark.Drivers.ComparisonSort.run_benchmark/1
    }
  end

  defp execute(algorithm, time) do
    driver = drivers()[algorithm]

    if driver != nil do
      Mix.Shell.IO.info("Starging Benchmarking Algorithm: #{algorithm}")
      driver.(time)
    else
      Mix.Shell.IO.error("Unknown algorithm: #{algorithm}")
    end
  end

  defp usage() do
    Mix.Shell.IO.info(Mix.Task.moduledoc(Mix.Tasks.Benchmark))
  end
end
