defmodule Day03 do
  def input do
    File.read!("./input/2022/day-03.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end

  def intersection([h|t]), do: intersection(h, t)
  def intersection(set, []), do: set
  def intersection(set, [h|t]), do: intersection(MapSet.intersection(set, h), t)

  def split_half(coll) do
    len = Enum.count(coll)
    Enum.split(coll, round(len / 2))
  end

  def score(c) when c < 96, do: c - 38
  def score(c), do: c - 96

  def solve(coll) do
    Enum.map(coll, fn coll ->
    Enum.map(coll, &MapSet.new/1)
    |> intersection
    |> MapSet.to_list
    |> List.first
    end)
    |> Enum.map(&score/1)
    |> Enum.sum
  end

  def part1 do
    input()
    |> Enum.map(fn coll ->
      split_half(coll)
      |> Tuple.to_list
    end)
    |> solve
  end

  def part2 do
    input()
    |> Enum.chunk_every(3)
    |> solve
  end
end
