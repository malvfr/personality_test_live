defmodule PersonalityTest.Questions.UseCaseTest do
  use ExUnit.Case
  alias PersonalityTest.Questions.UseCase
  alias PersonalityTest.Questions.InMemoryDb

  test "load_questions/1 reads a JSON file and returns its contents" do
    assert UseCase.load_questions("test/fixtures/sample.json") == [
             %{
               question: "What is your favorite color?",
               answers: [
                 %{score: 5, text: "Red"},
                 %{score: 3, text: "Blue"},
                 %{score: 1, text: "Green"}
               ]
             }
           ]
  end

  test "initialize_db/2 initializes the database with the given questions" do
    UseCase.initialize_db(:test, [
      %{
        question: "What is your favorite color?",
        answers: [
          %{score: 5, text: "Red"},
          %{score: 3, text: "Blue"},
          %{score: 1, text: "Green"}
        ]
      }
    ])

    assert InMemoryDb.get(:test) == %{
             questions: [
               %{
                 question: "What is your favorite color?",
                 answers: [
                   %{score: 5, text: "Red"},
                   %{score: 3, text: "Blue"},
                   %{score: 1, text: "Green"}
                 ]
               }
             ],
             current_question: 0,
             total_score: 0
           }
  end

  test "increment_current_question/1 increments the current question index" do
    UseCase.initialize_db(:test, [
      %{
        question: "What is your favorite color?",
        answers: [
          %{score: 5, text: "Red"},
          %{score: 3, text: "Blue"},
          %{score: 1, text: "Green"}
        ]
      }
    ])

    UseCase.increment_current_question(:test)
    data = InMemoryDb.get(:test)

    assert data.current_question == 1
  end
end
