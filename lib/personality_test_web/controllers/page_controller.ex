defmodule PersonalityTestWeb.PageController do
  alias PersonalityTest.Questions.InMemoryDb
  use PersonalityTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def result(conn, %{"id" => slug}) do
    with data when not is_nil(data) <- InMemoryDb.get(slug) do
      %{total_score: score} = data

      trait =
        cond do
          score <= 5 -> %{text: "Total introvert"}
          score > 5 and score <= 15 -> %{text: "Slightly introvert"}
          score > 15 and score <= 35 -> %{text: "Slightly extrovert"}
          score > 35 -> %{text: "Total extrovert"}
        end

      render(conn, "result.html", trait: trait)
    else
      _ -> redirect(conn, to: "/")
    end
  end

  def create(conn, _params) do
    slug = "/personality/" <> MnemonicSlugs.generate_slug()

    redirect(conn, to: slug)
  end
end
