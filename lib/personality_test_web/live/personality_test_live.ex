defmodule PersonalityTestWeb.PersonalityTestLive do
  use PersonalityTestWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
     <main class="col-md-6 mx-auto px-3 rounded-3 border shadow-lg p-3 mb-5 bg-body">
    </main>
    """
  end
end
