defmodule NumMethods do
  @moduledoc """
  Documentation for `NumMethods`. Examples of numerical methods in Elixir
  """

  @doc """
  Bisection

  ## Examples

      iex> NumMethods.bisection([2, 3, -3, 2, 9], [-2, 4], 0.005)
      "-1.2737 +/- 0.0005"

  """
  require Logger

  def bisection(coefficients, range, epsilon) do
    [a, exp1, b, exp2, c] = coefficients
    [a0, b0] = range
    Logger.info("Polynomial: " <> print_polynomial(a, exp1, b, exp2, c))
    bisection(a0, b0, epsilon, coefficients)
  end

  def bisection(a, b, epsilon, coefficients) do
    result = (a + b) / 2

    cond do
      f(a, coefficients) * f(b, coefficients) > 0 ->
        {:error, "Bad range"}

      check_result_closer_to_zero_than_epsilon(result, epsilon, coefficients) ->
        "#{Float.round(result, precision(epsilon, 0))}" <> " +/- " <> "#{epsilon}"

      left_or_right_side(a, result, coefficients) ->
        bisection(a, result, epsilon, coefficients)

      true ->
        bisection(result, b, epsilon, coefficients)
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

  def check_result_closer_to_zero_than_epsilon(result, epsilon, coefficients) do
    abs(f(result, coefficients)) < epsilon
  end

  def left_or_right_side(a, result, coefficients) do
    f(a, coefficients) * f(result, coefficients) < 0
  end

  def f(x, coefficients) do
    build_polynomial(x, coefficients)
  end


  def build_polynomial(x, coefficients) do
    [a, exp1, b, exp2, c] = coefficients
    a * x ** exp1 + b * x ** exp2 + c
  end

  def print_polynomial(a, exp1, b, exp2, c) do
    "#{a}x^#{exp1}+#{b}x^#{exp2}+#{c} = 0"
    |> String.replace("+-", "-")
    |> String.replace("--", "+")
  end
end
