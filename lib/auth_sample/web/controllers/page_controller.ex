defmodule AuthSample.Web.PageController do
  use AuthSample.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, [handler: AuthSample.GuardianErrorHandler]

  def index(conn, _params) do
    render conn, "index.html"
  end
end
