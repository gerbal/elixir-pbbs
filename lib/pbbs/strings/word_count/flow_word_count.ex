defmodule PBBS.Strings.WordCount.Flow do
  def word_count(string, p) do
    string
    |> String.to_charlist()
    |> Flow.from_enumerable()
    |> Flow.emit_and_reduce(fn -> [] end, &chunk_string/2)
    |> Flow.on_trigger(fn
      [] ->
        {[], []}

      acc ->
        {[acc], []}
    end)
    |> Flow.partition(stages: p)
    |> Flow.reject(&(&1 == []))
    |> Flow.map(&to_string/1)
    |> Flow.map(&String.reverse/1)
    |> Flow.partition(stages: p)
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
    |> Map.new()
  end

  # ascii uppercase, downcased
  defp chunk_string(v, acc) when v > 64 and v < 90, do: {[], [v + 32 | acc]}

  # ascii lowercase
  defp chunk_string(v, acc) when v > 96 and v < 123, do: {[], [v | acc]}

  defp chunk_string(_v, acc), do: {[acc], []}
end
