defmodule Aoc2020.PasswordPhilosophyTest do
  use ExUnit.Case

  alias Aoc2020.PasswordPhilosophy

  def password_data do
    "test/support/files/password_data.txt"
    |> Path.expand()
    |> File.read!()
  end

  test "find_violation_count/2 with sled rental rules" do
    assert 569 ==
             password_data()
             |> PasswordPhilosophy.find_violations(rules: :sled_rental)
             |> length()
  end

  test "find_violation_count/2 with toboggan rules" do
    assert 346 ==
             password_data()
             |> PasswordPhilosophy.find_violations(rules: :toboggan)
             |> length()
  end
end
