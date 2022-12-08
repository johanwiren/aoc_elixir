defmodule Day02 do
  def input do
    File.read!("./input/2022/day-02.txt")
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " ") end)
  end

  def part1_strategy([opp, "X"]), do: [opp, "A"]
  def part1_strategy([opp, "Y"]), do: [opp, "B"]
  def part1_strategy([opp, "Z"]), do: [opp, "C"]

  def score(["A", "A"]), do: 1 + 3
  def score(["A", "B"]), do: 2 + 6
  def score(["A", "C"]), do: 3 + 0
  def score(["B", "A"]), do: 1 + 0
  def score(["B", "B"]), do: 2 + 3
  def score(["B", "C"]), do: 3 + 6
  def score(["C", "A"]), do: 1 + 6
  def score(["C", "B"]), do: 2 + 0
  def score(["C", "C"]), do: 3 + 3

  def solve(strategy) do
    input()
    |> Enum.map(strategy)
    |> Enum.map(&score/1)
    |> Enum.sum
  end

  def part1 do
    solve(&part1_strategy/1)
  end

  def part2_strategy(["A", "X"]), do: ["A", "C"]
  def part2_strategy(["B", "X"]), do: ["B", "A"]
  def part2_strategy(["C", "X"]), do: ["C", "B"]
  def part2_strategy([opp, "Y"]), do: [opp, opp]
  def part2_strategy(["A", "Z"]), do: ["A", "B"]
  def part2_strategy(["B", "Z"]), do: ["B", "C"]
  def part2_strategy(["C", "Z"]), do: ["C", "A"]

  def part2 do
    solve(&part2_strategy/1)
  end

end

