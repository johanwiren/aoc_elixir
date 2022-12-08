defmodule Day05 do
  def butlast(enum) do
    Enum.slice(enum, 0, length(enum) - 1)
  end

  def parse_stacks(stacks) do
    stacks
    |> butlast
    |> Enum.map(fn stack ->
      String.to_charlist(stack)
      |> Enum.chunk_every(4)
      |> Enum.map(fn x ->
        {res, _} = List.pop_at(x, 1)
        res
      end)
    end)
    |> Enum.zip_with(&(&1))
    |> Enum.map(fn e -> Enum.reject(e, &(&1 == 32)) end)
  end

  def parse_move(move) do
    String.split(move)
    |> Enum.chunk_every(2)
    |> Map.new(fn [k, v] -> {String.to_atom(k), String.to_integer(v)} end)
    |> Map.update!(:from, &(&1 - 1))
    |> Map.update!(:to, &(&1 - 1))
  end

  def input do
    [stacks, _, moves, _] = File.read!("./input/2022/day-05.txt")
    |> String.split("\n", trim: false)
    |> Enum.chunk_by(&(&1 == ""))

    %{:stacks => parse_stacks(stacks),
      :moves => Enum.map(moves, &parse_move/1)}
  end

  def solve(f) do
    %{stacks: stacks, moves: moves} = input()
    List.foldl(moves, stacks, fn move, acc ->
      %{from: from, to: to, move: count} = move
      {stack, _} = List.pop_at(acc, from)
      {taken, left} = Enum.split(stack, count)
      acc
      |> List.update_at(from, fn _ -> left end)
      |> List.update_at(to, fn xs -> f.(taken) ++ xs end)
    end)
    |> Enum.map(&(List.first(&1)))
  end

  def part1 do
    solve(&Enum.reverse/1)
  end

  def part2 do
    solve(&(&1))
  end
end
