defmodule PersonalityTestWeb.PageController do
  use PersonalityTestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def result(conn, _params) do
    render(conn, "result.html")
  end

  def create(conn, _params) do
    slug = "/personality/" <> MnemonicSlugs.generate_slug()

    redirect(conn, to: slug)
  end
end
