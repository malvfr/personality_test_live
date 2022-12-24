defmodule PersonalityTest.Questions.UseCase do
  alias PersonalityTest.Questions.InMemoryDb
  alias PersonalityTest.Util.Json

  def load_questions(file_path) do
    Json.read_json_file(file_path)
  end

  def initialize_db(slug, questions) do
    InMemoryDb.put(slug, %{questions: questions, current_question: 0, total_score: 0})
  end

  def increment_current_question(slug) do
    slug
    |> InMemoryDb.get()
    |> update_in([:current_question], &(&1 + 1))
    |> then(fn state -> InMemoryDb.put(slug, state) end)
  end

  def increment_score(slug, score) do
    slug
    |> InMemoryDb.get()
    |> update_in([:total_score], &(&1 + score))
    |> then(fn state -> InMemoryDb.put(slug, state) end)
  end
end
