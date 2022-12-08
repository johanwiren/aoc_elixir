defmodule Day07 do
  def tree_map(m, cwd, [h|t]) do
    case h do
      ["$", "cd", ".."] ->
        [_ | parent_dir] = cwd
        tree_map(m, parent_dir, t)

      ["$", "cd", path] ->
        path = [path | cwd]
        Map.put(m, path, 0)
        |> tree_map(path, t)

      ["$", "ls"] -> tree_map(m, cwd, t)

      ["dir", _] -> tree_map(m, cwd, t)

      [size, _] ->
        size = String.to_integer(size)
        dirs_to_update = Stream.iterate(cwd, &tl/1) |> Enum.take_while(&(&1 != []))
        Enum.reduce(dirs_to_update, m, fn dir, acc ->
          Map.update(acc, dir, 0, &(&1 + size))
        end)
        |> tree_map(cwd, t)
      _ -> tree_map(m, cwd, t)
    end
  end
  def tree_map(m, _cwd, []) do
    m
  end
  def tree_map([h|t]) do
    tree_map(%{}, [], [h|t])
  end

  def part1 do
    input() |> tree_map |> Map.values |> Stream.filter(&(&1 < 100000)) |> Enum.sum
  end

  def part2 do
    tree_map = input() |> tree_map
    total_size = 70000000
    used = Map.get(tree_map, ["/"])
    free = total_size - used
    needed_free = 30000000 - free
    Map.values(tree_map) |> Stream.filter(&(&1 > needed_free)) |> Enum.sort |> List.first
  end

  def input do
    File.read!("./input/2022/day-07.txt")
    |> String.split("\n", trim: false)
    |> Enum.map(&(String.split(&1, " ", trim: true)))
  end
end
