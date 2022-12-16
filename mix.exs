defmodule PBBS.MixProject do
  use Mix.Project

  def project do
    [
      app: :pbbs,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :tools]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_csv, "~> 1.0", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp escript do
    [main_module: PBBS]
  end

  defp aliases do
    [
      "benchmark.all": [
        "benchmark -a histogram",
        "benchmark -a remove_duplicates",
        "benchmark -a word_count",
        "benchmark -a ray_cast",
        "benchmark -a convex_hull",
        "benchmark -a suffix_array",
        "benchmark -a integer_sort",
        "benchmark -a comparison_sort"
      ]
    ]
  end
end
