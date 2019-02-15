defmodule PrimescrambleTest do
  use ExUnit.Case
  doctest Primescramble

  test "greets the world" do
    assert Primescramble.hello() == :world
  end
end
