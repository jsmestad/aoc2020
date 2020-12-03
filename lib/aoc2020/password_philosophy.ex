defmodule Aoc2020.PasswordPhilosophy do
  require Logger

  def find_violations(str, rules: rules) do
    result =
      str
      |> String.split("\n")
      |> Enum.map(&convert/1)

    case rules do
      :sled_rental ->
        Enum.filter(result, &is_violation?(&1, rules))

      :toboggan ->
        Enum.filter(result, &is_valid?(&1, rules))
    end
  end

  defp convert(row) do
    [range, letter, entry] = String.split(row, " ")
    [min, max] = range |> String.split("-") |> Enum.map(&String.to_integer/1)
    letter = String.at(letter, 0)
    {{min, max}, letter, entry}
  end

  defp is_violation?({{min, max}, letter, entry}, :sled_rental) do
    occurrences =
      letter
      |> Regex.compile!()
      |> Regex.scan(entry)
      |> length()

    occurrences >= min && occurrences <= max
  end

  defp is_valid?({{min, max}, letter, entry}, :toboggan) do
    letters = [String.at(entry, min - 1), String.at(entry, max - 1)]

    case letters do
      [^letter, ^letter] ->
        log(:invalid, entry, letter, min, max)
        false

      [^letter, _any] ->
        log(:valid, entry, letter, min, max)
        true

      [_any, ^letter] ->
        log(:valid, entry, letter, min, max)
        true

      _ ->
        log(:invalid, entry, letter, min, max)
        false
    end
  end

  defp log(:valid, entry, letter, min, max),
    do:
      Logger.debug(
        "[VALID] Entry: #{entry} | Letter: #{letter} | Min: #{min - 1} | Max: #{max - 1}"
      )

  defp log(:invalid, entry, letter, min, max),
    do:
      Logger.debug(
        "[INVALID] Entry: #{entry} | Letter: #{letter} | Min: #{min - 1} | Max: #{max - 1}"
      )
end
