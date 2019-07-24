defmodule TutorialTest do
  use ExUnit.Case
  doctest Tutorial

  test "greets the world" do
    assert Tutorial.hello() == :world
  end
end
