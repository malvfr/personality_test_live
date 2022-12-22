defmodule PersonalityTest.Util.Json do
  def read_json_file(file_path) do
    try do
      file_contents = File.read!(file_path)
      Jason.decode!(file_contents, keys: :atoms)
    catch
      exception ->
        raise exception
    end
  end
end
