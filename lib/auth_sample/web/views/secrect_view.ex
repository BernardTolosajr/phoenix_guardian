defmodule AuthSample.Web.SecrectView do
  use AuthSample.Web, :view
  alias AuthSample.Web.SecrectView

  def render("index.json", %{account: account}) do
    %{data: render_one(account, SecrectView, "account.json")}
  end

  def render("account.json", %{secrect: account}) do
    %{id: account.id,
      email: account.email,
      password_digest: account.password_digest}
  end
end
