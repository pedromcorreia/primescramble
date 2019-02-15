defmodule Primescramble do
  @moduledoc """
  Documentation for Primescramble.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Primescramble.hello()
      :world

  """
  @alphabet%{"A" => 1, "B" => 2, "C" => 3, "D" => 4, "E" => 5, "F" => 6, "G" => 7, "H" => 8, "I" => 9, "J" => 10, "K" => 11, "L" => 12, "M" => 13, "N" => 14, "O" => 15, "P" => 16, "Q" => 17, "R" => 18, "S" => 19, "T" => 20, "U" => 21, "V" => 22, "W" => 23, "X" => 24, "Y" => 25, "Z" => 26}
  def decoding(encrypted) do
    encrypted
    |> String.graphemes()
    |> Enum.map(fn x ->
      <<v::utf8>> = x
      value_ascii =
        find_index_alphabet(x)
        |> Kernel.+(1)
        |> get_primes()
        |> List.last()
    end)
  end

  defp find_index_alphabet(word) do
    Map.get(@alphabet, String.upcase(word))
  end

  def get_primes(n) when n < 2, do: []
  def get_primes(n), do: Enum.filter(2..n, &is_prime?(&1))

  defp is_prime?(n) when n in [2, 3], do: true
  defp is_prime?(x) do
    start_lim = div(x, 2)
    Enum.reduce(2..start_lim, {true, start_lim}, fn(fac, {is_prime, upper_limit}) ->
      cond do
        !is_prime -> {false, fac}
        fac > upper_limit -> {is_prime, upper_limit}
        true ->
          is_prime = rem(x, fac) != 0
          upper_limit = if is_prime, do: div(x, fac + 1), else: fac
          {is_prime , upper_limit}
      end
    end) |> elem(0)
  end
end
