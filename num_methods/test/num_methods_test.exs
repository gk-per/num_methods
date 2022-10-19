defmodule NumMethodsTest do
  use ExUnit.Case
  doctest NumMethods

  test "greets the world" do
    assert NumMethods.hello() == :world
  end
end
