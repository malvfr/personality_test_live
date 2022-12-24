defmodule PersonalityTest.Questions.InMemoryDb do
  use Agent

  def start_link(initial_state \\ %{}) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def get(slug) do
    Agent.get(__MODULE__, fn state -> Map.get(state, slug) end)
  end

  def put(slug, value) do
    Agent.update(__MODULE__, fn state -> Map.put(state, slug, value) end)
  end

  def delete(slug) do
    Agent.update(__MODULE__, fn state -> Map.delete(state, slug) end)
  end
end
