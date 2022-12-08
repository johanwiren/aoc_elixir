defmodule Day04 do
  def input do
    File.read!("./input/2022/day-04.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      Regex.scan(~r/\d+/, s)
      |> Enum.map(&List.first/1)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.map(fn [a, b, x, y] ->
      {Range.new(a, b), Range.new(x, y)}
    end)
  end

  def subset?(r1, r2) do
    r1_first..r1_last//_ = r1
    r2_first..r2_last//_ = r2
    r2_first <= r1_first and r1_last <= r2_last
  end

  def has_full_overlap({r1, r2}) do
    subset?(r1, r2) or subset?(r2, r1)
  end

  def has_any_overlap({r1, r2}) do
    !Range.disjoint?(r1, r2)
  end

  def part1 do
    input()
    |> Enum.filter(&has_full_overlap/1)
    |> length
  end

  def part2 do
    input()
    |> Enum.filter(&has_any_overlap/1)
    |> length
  end
end
