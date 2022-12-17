defmodule PBBS.Strings.WordCount.Sequential do
  def word_count(string) do
    String.split(string, ~r/[^A-Za-z]+/)
    |> Enum.map(&String.downcase/1)
    |> Enum.frequencies()
  end
end
