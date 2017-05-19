defmodule AuthSample.Web.AccountView do
  use AuthSample.Web, :view
  alias AuthSample.Web.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      email: account.email,
      password_digest: account.password_digest}
  end
end
