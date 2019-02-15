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
  @alphabet~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
  def decoding(encrypted) do
    encrypted
    |> String.graphemes()
    |> Enum.map(fn x ->
      <<v::utf8>> = x
      get_primes(v) |> List.last()
    end)
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
