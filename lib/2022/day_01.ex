defmodule Day01 do
  def input do
    File.read!("./input/2022/day-01.txt")
    |> String.split("\n", trim: false)
    |> Enum.map(fn
      "" -> nil
      n -> String.to_integer(n)
    end)
    |> Enum.chunk_by(&(&1 == nil))
    |> Enum.reject(&(&1 == [nil]))
  end

  def part1 do
    input()
    |> Enum.map(&Enum.sum/1)
    |> Enum.max
  end

  def part2 do
    input()
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort_by(&(- &1))
    |> Enum.take(3)
    |> Enum.sum
  end
end
