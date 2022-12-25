defmodule PersonalityTestWeb.PersonalityTestLiveTest do
  use ExUnit.Case

  alias PersonalityTestWeb.Endpoint
  alias PersonalityTest.Questions.InMemoryDb
  alias PersonalityTest.Questions

  use PersonalityTestWeb.ConnCase
  import Phoenix.LiveViewTest

  test "connected mount", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/personality/slug")

    assert view.module == PersonalityTestWeb.PersonalityTestLive
  end

  test "when form is submitted, increase the question counter and adds to the total_score", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, "/personality/slug")

    db_state = InMemoryDb.get("slug")

    assert db_state.current_question == 0
    assert db_state.total_score == 0

    view
    |> element("form")
    |> render_submit(%{"question_weight" => 10})

    db_state = InMemoryDb.get("slug")

    assert db_state.current_question == 1
    assert db_state.total_score == 10
  end

  test "should redirect to the results page when questions are finished", %{
    conn: conn
  } do
    {:ok, view, _html} = live(conn, "/personality/new_slug")

    for _ <- 1..5 do
      view
      |> element("form")
      |> render_submit(%{"question_weight" => 10})
    end

    assert_redirect(view, "/result?id=new_slug", 30)
  end
end
