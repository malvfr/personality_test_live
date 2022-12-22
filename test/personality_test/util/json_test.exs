defmodule PersonalityTest.Util.JsonTest do
  use ExUnit.Case
  alias PersonalityTest.Util.Json

  test "can read valid JSON file" do
    # Arrange
    file_path = "test/fixtures/valid.json"
    expected_result = %{test_sample: "sample"}

    # Act
    result = Json.read_json_file(file_path)

    # Assert
    assert result == expected_result
  end

  test "raises error for invalid JSON file" do
    # Arrange
    file_path = "test/fixtures/invalid.json"

    # Act and assert
    assert_raise Jason.DecodeError, fn ->
      Json.read_json_file(file_path)
    end
  end

  test "raises error for non-existent file" do
    # Arrange
    file_path = "test/fixtures/nonexistent_file.json"

    # Act and assert
    assert_raise File.Error, fn ->
      Json.read_json_file(file_path)
    end
  end
end
