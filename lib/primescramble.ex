defmodule Primescramble do
  @moduledoc """
  Documentation for Primescramble.
  """

  def decode(encrypted) do
    encrypted
    |> String.graphemes()
    |> get_decoded()
    |> elem(1)
  end

  def get_decoded(graphemes) do
    graphemes
    |> Enum.reduce({0, ""}, fn x, acc ->
      <<v::utf8>> = x
      {acc_number, acc_string} = acc
      prime_number = nextprime(acc_number)
      decoded_string = sanitaze_chart_ascii(v - prime_number)
      {prime_number, acc_string <> <<decoded_string::utf8>>}
    end)
  end

  defp sanitaze_chart_ascii(char_value) when char_value < 33 do
    sanitaze_chart_ascii(char_value + 93)
  end

  defp sanitaze_chart_ascii(char_value) do
    char_value
  end

  def prime?(2), do: true

  def prime?(num) when is_integer(num) do
    last =
      num
      |> :math.sqrt()
      |> Float.ceil()
      |> trunc

    notprime =
      2..last
      |> Enum.any?(fn a -> rem(num, a) == 0 end)

    !notprime
  end

  def nextprime(num) when is_integer(num) do
    cond do
      prime?(num + 1) -> num + 1
      true -> nextprime(num + 1)
    end
  end

  def nthprime(n) when is_integer(n) do
    Stream.iterate(2, &nextprime/1)
    |> Enum.at(n - 1)
  end

  defp divisors(num) do
    do_divisors(num, 1)
  end

  defp do_divisors(num, n) do
    cond do
      prime?(num) ->
        [num]

      rem(num, nthprime(n)) == 0 ->
        [
          nthprime(n)
          | do_divisors(trunc(num / nthprime(n)), n)
        ]

      true ->
        do_divisors(num, n + 1)
    end
  end
end
