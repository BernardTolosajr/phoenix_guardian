defmodule AuthSample.Web.SessionView do
  use AuthSample.Web, :view
  alias AuthSample.Web.SessionView

  def render("login.json", %{jwt: jwt}) do
    %{ jwt: jwt }
  end

  def render("error.json", _assigns) do
    %{success: "false"}
  end
end
