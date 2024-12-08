defmodule AocGeneratorTest do
  use ExUnit.Case
  doctest AocGenerator

  test "greets the world" do
    assert AocGenerator.hello() == :world
  end
end
