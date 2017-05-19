defmodule AuthSample.Web.SessionController do
  use AuthSample.Web, :controller
  alias AuthSample.Accounts
  alias AuthSample.Accounts.Account

  action_fallback AuthSample.Web.FallbackController

  def create(conn, %{"account" => %{"email" => email, "password" => password}}) do
    with {:ok, account} <- Accounts.verify(email, password) do
      conn
      |> sign_in(account)
      |> render("login.json")
    else _ ->
      conn
      |> put_status(:unprocessable_entity)
      |> render("error.json")
    end
  end

  defp sign_in(conn, account) do
    conn
    |> Guardian.Plug.api_sign_in(account)
    |> add_jwt
  end

  defp add_jwt(conn) do
    jwt = Guardian.Plug.current_token(conn)
    assign(conn, :jwt, jwt)
  end
end
