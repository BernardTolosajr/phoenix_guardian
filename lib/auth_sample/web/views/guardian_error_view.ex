defmodule AuthSample.GuardianErrorView do
  use AuthSample.Web, :view

  def render("forbidden.json", %{message: message}) do
    %{message: message}
  end
end
