defmodule Aoc2020.TobogganTrajectory do
  require Logger

  def part_one(input) do
    map = parse_layout(input)
    end_row = length(map) - 1

    Enum.map(1..end_row, fn i ->
      row = Enum.fetch!(map, i)
      position = i * 3

      check_for_tree(row, position)
    end)
    |> Enum.count(fn result -> result == :hit end)
  end

  defp check_for_tree(row, position) do
    str = "Row #{String.to_charlist(row)} (#{String.length(row)}) | Position #{position}"
    cell = rem(position, String.length(row))

    result =
      case String.at(row, cell) do
        "#" -> :hit
        _ -> :miss
      end

    IO.puts("#{result} | Cell #{cell} | #{str}")
    result
  end

  def part_two(input) do
    movements_per_row = [1, 3, 5, 7]

    map = parse_layout(input)
    end_row = length(map) - 1

    Enum.map(1..end_row, fn i ->
      row = Enum.fetch!(map, i)
      row_length = String.length(row)

      values =
        movements_per_row
        |> Enum.map(&rem(&1 * i, row_length))
        |> Enum.map(fn cell ->
          row |> String.at(cell) |> check_cell()
        end)

      val =
        if Integer.mod(i, 2) == 0 do
          row |> String.at(rem(div(i, 2), row_length)) |> check_cell()
        else
          :miss
        end

      [val | values]
    end)
    |> transpose()
    |> Enum.map(&Enum.reject(&1, fn x -> x == :miss end))
    |> Enum.reduce(1, fn n, acc -> length(n) * acc end)
  end

  def check_cell("#"), do: :hit
  def check_cell(_), do: :miss

  def transpose([]), do: []
  def transpose([[] | _]), do: []

  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  defp parse_layout(input) do
    input |> String.trim() |> String.split("\n")
  end
end
