defmodule Day06 do
  def input do
    File.read!("./input/2022/day-06.txt")
    |> String.to_charlist
  end

  def distinct?([]), do: true
  def distinct?([_]), do: true
  def distinct?(enum), do: distinct?(MapSet.new(), enum)
  def distinct?(_, []), do: true
  def distinct?(seen, [h|t]) do
    if MapSet.member?(seen, h) do
      false
    else
      distinct?(MapSet.put(seen, h), t)
    end
  end

  def find_marker(enum, marker_size) do
    {_, pos} = enum
    |> Enum.chunk_every(marker_size, 1)
    |> Enum.with_index(marker_size)
    |> Enum.filter(fn {enum, _} -> distinct?(enum) end)
    |> List.first
    pos
  end

  def part1 do
    input() |> find_marker(4)
  end

  def part2 do
    input() |> find_marker(14)
  end
end
