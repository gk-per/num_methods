defmodule NumMethodsTest do
  use ExUnit.Case
  doctest NumMethods

  test "bisection" do
    assert NumMethods.bisection() == "-1.2737 +/- 0.0005"
  end
end
