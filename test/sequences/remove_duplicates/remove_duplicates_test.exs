defmodule RemoveDuplicatesTest do
  use ExUnit.Case

  test "sequential implementation removes duplicates correctly" do
    input = [0, 0, 0, 1, 2, 3, 1, 2, 3, 4, 5, 6, 4, 5, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9]

    assert PBBS.Sequences.RemoveDuplicates.Sequential.remove_duplicates(input) == [
             0,
             1,
             2,
             3,
             4,
             5,
             6,
             7,
             8,
             9
           ]
  end

  test "parallel implementation removes duplicates correctly" do
    input = [0, 0, 0, 1, 2, 3, 1, 2, 3, 4, 5, 6, 4, 5, 6, 7, 7, 7, 8, 8, 8, 9, 9, 9]

    assert MapSet.new(PBBS.Sequences.RemoveDuplicates.Parallel.remove_duplicates(input, 6)) ==
             MapSet.new([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
  end
end
