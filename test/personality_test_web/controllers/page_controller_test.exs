defmodule PersonalityTestWeb.PageControllerTest do
  alias PersonalityTest.Questions.InMemoryDb
  use PersonalityTestWeb.ConnCase

  test "GET /result without a valid InMemoryDB state, redirects user to the landing page", %{
    conn: conn
  } do
    conn = get(conn, "/result", %{"id" => "test"})
    assert redirected_to(conn, 302) == "/"
  end

  test "GET /result with a valid InMemoryDB state, renders the correct page", %{
    conn: conn
  } do
    InMemoryDb.put("test_slug", %{total_score: 100})

    conn = get(conn, "/result", %{"id" => "test_slug"})
    assert html_response(conn, 200)
  end

  test "POST / should create a new slug and redirect to it", %{
    conn: conn
  } do
    conn = post(conn, "/")
    assert redirected_to(conn, 302) =~ "/personality/"
  end
end
