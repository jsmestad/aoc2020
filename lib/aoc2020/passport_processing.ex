defmodule Aoc2020.PassportProcessing do
  @required_keys ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

  @rules [
    ~r/\bbyr:(19(?:2[0-9]|[3-9][0-9])|200[0-2])\b/,
    ~r/\biyr:(20(?:1[0-9]|20))\b/,
    ~r/\beyr:(20(?:2[0-9]|30))\b/,
    ~r/\bhgt:(1(?:[5-8][0-9]|9[0-3])cm|(?:59|6[0-9]|7[0-6])in)\b/,
    ~r/\bhcl:(#[a-f0-9]{6})\b/,
    ~r/\becl:(amb|blu|brn|gry|grn|hzl|oth)\b/,
    ~r/\bpid:\d{9}\b/
  ]

  def part_one(str) do
    str
    |> parse()
    |> Enum.count(&valid_passport?/1)
  end

  def part_two(str) do
    str
    |> parse()
    |> Enum.count(&valid_passport_rules?/1)
  end

  defp parse(str) do
    str |> String.split("\n\n") |> Enum.map(&String.split(&1, ["\n", " "]))
  end

  def valid_passport?(fields) do
    Enum.all?(@required_keys, fn key -> Enum.any?(fields, &String.starts_with?(&1, key)) end)
  end

  def valid_passport_rules?(fields) do
    fields = Enum.join(fields, " ")

    Enum.all?(@rules, fn rule ->
      Regex.match?(rule, fields)
    end)
  end
end
