defmodule PrimescrambleTest do
  use ExUnit.Case
  doctest Primescramble

  test "decode" do
    assert Primescramble.decode("cqil}##$E3.79>AuKEXMMXW_mt8{u") ==
             "anderson.slompo@mercafacil.me"

    assert Primescramble.decode("ohhvy$&t.!/->13>?COV") == "mecontratamercafacil"
  end

  test "get_decoded" do
    assert Primescramble.get_decoded([
             "c",
             "q",
             "i",
             "l",
             "}",
             "#",
             "#",
             "$",
             "E",
             "3",
             ".",
             "7",
             "9",
             ">",
             "A",
             "u",
             "K",
             "E",
             "X",
             "M",
             "M",
             "X",
             "W",
             "_",
             "m",
             "t",
             "8",
             "{",
             "u"
           ]) == {109, "anderson.slompo@mercafacil.me"}

    assert Primescramble.get_decoded([
             "o",
             "h",
             "h",
             "v",
             "y",
             "$",
             "&",
             "t",
             ".",
             "!",
             "/",
             "-",
             ">",
             "1",
             "3",
             ">",
             "?",
             "C",
             "O",
             "V"
           ]) == {71, "mecontratamercafacil"}
  end

  test "prime?" do
    assert Primescramble.prime?(1) == false
    assert Primescramble.prime?(2) == true
    assert Primescramble.prime?(3) == true
    assert Primescramble.prime?(4) == false
    assert Primescramble.prime?(5) == true
  end

  test "nextprime" do
    assert Primescramble.nextprime(1) == 2
    assert Primescramble.nextprime(2) == 3
    assert Primescramble.nextprime(3) == 5
    assert Primescramble.nextprime(4) == 5
    assert Primescramble.nextprime(5) == 7
  end

  test "nthprime" do
    assert Primescramble.nthprime(1) == 2
    assert Primescramble.nthprime(2) == 3
    assert Primescramble.nthprime(3) == 5
    assert Primescramble.nthprime(4) == 7
    assert Primescramble.nextprime(5) == 7
  end
end
