defmodule Aoc2020.ReportRepairTest do
  use ExUnit.Case

  alias Aoc2020.ReportRepair

  @entires [979, 1721, 366, 299, 675, 1456]

  describe "two number combination" do
    test "finds sum of target" do
      assert {:ok, {299, 1721}} =
               ReportRepair.find_sum(%{in: @entires, total: 2020, combination: 2})
    end

    test "multiply values" do
      assert %{in: @entires, total: 2020, combination: 2}
             |> ReportRepair.find_sum()
             |> ReportRepair.calculate() == 514_579
    end
  end

  describe "three number combination" do
    test "finds sum of target" do
      assert {:ok, {979, 366, 675}} =
               ReportRepair.find_sum(%{in: @entires, total: 2020, combination: 3})
    end

    test "multiply values" do
      assert %{in: @entires, total: 2020, combination: 3}
             |> ReportRepair.find_sum()
             |> ReportRepair.calculate() == 241_861_950
    end
  end
end
