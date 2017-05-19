defmodule AuthSample.Web.SecrectController do
  use AuthSample.Web, :controller

  alias AuthSample.Accounts
  alias AuthSample.Accounts.Account

  plug Guardian.Plug.EnsureAuthenticated, [handler: AuthSample.GuardianErrorHandler]

  def index(conn, _params) do
    account = Guardian.Plug.current_resource(conn)
    render(conn, "index.json", %{account: account})
  end
end
