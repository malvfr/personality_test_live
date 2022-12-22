defmodule PersonalityTest.Questions.UseCase do
  alias PersonalityTest.Util.Json

  def load_questions(file_path) do
    Json.read_json_file(file_path)
  end
end
