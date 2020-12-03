defmodule Aoc2020.ReportRepair do
  def calculate({:ok, {a, b, c}}), do: a * b * c
  def calculate({:ok, {a, b}}), do: a * b
  def calculate(_), do: nil

  @spec find_sum(map()) ::
          {:ok, {integer(), integer()} | {integer(), integer(), integer()}}
          | {:error, :no_match_found}
  def find_sum(%{in: entries, total: total, combination: combination}) do
    entries
    |> combine(combination)
    |> Enum.reject(&is_duplicate?/1)
    |> Enum.find(&equals_target?(&1, total))
    |> case do
      nil ->
        {:error, :no_match_found}

      {a, b, c} ->
        {:ok, {a, b, c}}

      {a, b} ->
        if a > b do
          {:ok, {b, a}}
        else
          {:ok, {a, b}}
        end
    end
  end

  defp equals_target?({a, b}, total), do: a + b == total
  defp equals_target?({a, b, c}, total), do: a + b + c == total

  defp is_duplicate?({a, a}), do: true
  defp is_duplicate?({a, a, a}), do: true
  defp is_duplicate?(_), do: false

  defp combine(entries, 2) do
    for i <- entries, j <- entries, do: {i, j}
  end

  defp combine(entries, 3) do
    for i <- entries, j <- entries, k <- entries, do: {i, j, k}
  end

  def find([head | [next | rest]], target) do
    case head + next do
      ^target -> {:ok, {head, next}}
      _ -> find([head | rest], target)
    end
  end

  def find(_list, _target) do
    {:error, :no_match_found}
  end
end
