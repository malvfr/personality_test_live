defmodule PersonalityTestWeb.PersonalityTestLive do
  alias PersonalityTest.Questions.InMemoryDb
  alias PersonalityTest.Questions

  use PersonalityTestWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    questions = Questions.UseCase.load_questions("resources/questions.json")
    slug = params["id"]

    socket =
      slug
      |> InMemoryDb.get()
      |> case do
        nil ->
          Questions.UseCase.initialize_db(slug, questions)

          socket
          |> assign(:questions, questions)
          |> assign(:current_question, 0)

        data ->
          socket
          |> assign(:questions, data.questions)
          |> assign(:current_question, data.current_question)
      end
      |> assign(:slug, slug)

    {:ok, socket}
  end

  @impl true
  def handle_event("save", params, socket) do
    current_question = socket.assigns.current_question
    total_questions = length(socket.assigns.questions)
    slug = socket.assigns.slug

    if current_question < total_questions - 1 do
      socket = socket |> assign(:current_question, current_question + 1)

      Questions.UseCase.increment_current_question(slug)
      Questions.UseCase.increment_score(slug, String.to_integer(params["question_weight"]))

      {:noreply, socket}
    else
      {:noreply, push_redirect(socket, to: "/result?id=#{socket.assigns.slug}")}
    end
  end

  @impl true
  def render(assigns) do
    row = Enum.at(assigns.questions, assigns.current_question)

    ~H"""
     <main class="col-md-12 mx-auto px-3 rounded-3 border shadow-lg p-3 mb-5 bg-body">
      <div class="d-flex justify-content-between p-1">
        <h3 style= "color: #22A39F" class="my-1"> <%= row.dimension %> </h3>
        <h3 style= "color: #22A39F" class="my-1"> <%= assigns.current_question + 1%> / <%= length(assigns.questions) %> </h3>
      </div>
       <hr/>
       <h4> <%= row.question%> </h4>
         <.form let={_f} for={:questions} phx-submit="save">
             <%= for answer <- row.answers  do %>
               <div class="form-check p-3 ms-2">
                 <input required type="radio" class="form-check-input" name="question_weight" value={answer.weight}><%= answer.text %>
               </div>
             <% end %>
             <%= submit("Next", class: "btn btn-md btn-secondary fw-bold border-white") %>
         </.form>
    </main>
    """
  end
end
