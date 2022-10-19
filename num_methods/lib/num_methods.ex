defmodule NumMethods do
  @moduledoc """
  Documentation for `NumMethods`. Examples of numerical methods in Elixir
  """

  @doc """
  Bisection

  ## Examples

      iex> NumericalMethods.bisection()
      2.1015625

  """
  def bisection() do
    [a, b] = [1.0, 5.0]
    epsilon = 0.05

    operate(a, b, epsilon)
  end

  def operate(a, b, epsilon) do
    result = (a + b) / 2
   IO.inspect(result, label: "guess")

    # initial guess check
    if f(a) * f(b) > 0, do: :error

    if abs(f(result)) < epsilon do
      result
    else
      if f(a) * f(result) < 0 do
        operate(a, result, epsilon)
      else
        operate(result, b, epsilon)
      end
    end
  end

  def f(x) do
    x * x * x * x - 5 * x - 9
  end
end
