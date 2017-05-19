defmodule AuthSample.GuardianErrorHandler do
  use AuthSample.Web, :controller
  alias AuthSample.GuardianErrorView

  def unauthenticated(conn, _params) do
    conn
    |> put_status(401)
    |> render(GuardianErrorView, "forbidden.json", message: "Authentication required")
  end
end
