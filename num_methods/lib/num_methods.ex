defmodule NumMethods do
  @moduledoc """
  Documentation for `NumMethods`. Examples of numerical methods in Elixir
  """

  @doc """
  Bisection

  ## Examples

      iex> NumMethods.bisection()
      "-1.2737 +/- 0.0005"

  """
  def bisection() do
    IO.inspect(print_polynomial(2, 3, -3, 2, 9))
    [a, b] = [-2.0, 4.0]
    epsilon = 0.0005

    bisection(a, b, epsilon)
  end

  def bisection(a, b, epsilon) do
    result = (a + b) / 2

    cond do
      f(a) * f(b) > 0 ->
        {:error, "Bad range"}

      check_result_closer_to_zero_than_epsilon(result, epsilon) ->
        "#{Float.round(result, precision(epsilon, 0))}" <> " +/- " <> "#{epsilon}"

      left_or_right_side(a, result) ->
        bisection(a, result, epsilon)

      true ->
        bisection(result, b, epsilon)
    end
  end

  def precision(epsilon, i) do
    cond do
      epsilon > 1 ->
        i

      epsilon < 1 ->
        precision(epsilon * 10, i + 1)
    end
  end

  def check_result_closer_to_zero_than_epsilon(result, epsilon) do
    abs(f(result)) < epsilon
  end

  def left_or_right_side(a, result) do
    f(a) * f(result) < 0
  end

  def f(x) do
    build_polynomial(x, 2, 3, -3, 2, 9)
  end

  def build_polynomial(x, a, exp1, b, exp2, c) do
    a * x ** exp1 + b * x ** exp2 + c
  end

  def print_polynomial(a, exp1, b, exp2, c) do
    "#{a}x^#{exp1}+#{b}x^#{exp2}+#{c} = 0"
    |> String.replace("+-", "-")
    |> String.replace("--", "+")
  end

  def g(x) do
    6 * x * x - 6 * x
  end
end
