defmodule PersonalityTest.Questions.InMemoryDbTest do
  use ExUnit.Case
  alias PersonalityTest.Questions.InMemoryDb

  test "get/1 returns the value for a given key" do
    InMemoryDb.put(:foo, "bar")
    assert InMemoryDb.get(:foo) == "bar"
  end

  test "put/2 updates the value for a given key" do
    InMemoryDb.put(:foo, "bar")
    InMemoryDb.put(:foo, "baz")
    assert InMemoryDb.get(:foo) == "baz"
  end

  test "delete/1 removes the key-value pair from the database" do
    InMemoryDb.put(:foo, "bar")
    InMemoryDb.delete(:foo)
    assert InMemoryDb.get(:foo) == nil
  end

  test "delete/1 removes the value for the given key" do
    InMemoryDb.put(:key, "value")
    assert InMemoryDb.get(:key) == "value"
    InMemoryDb.delete(:key)
    assert InMemoryDb.get(:key) == nil
  end
end
