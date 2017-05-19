defmodule AuthSample.Web.AccountControllerTest do
  use AuthSample.Web.ConnCase

  alias AuthSample.Accounts
  alias AuthSample.Accounts.Account

  @create_attrs %{email: "some email", password_digest: "some password_digest"}
  @update_attrs %{email: "some updated email", password_digest: "some updated password_digest"}
  @invalid_attrs %{email: nil, password_digest: nil}

  def fixture(:account) do
    {:ok, account} = Accounts.create_account(@create_attrs)
    account
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, account_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates account and renders account when data is valid", %{conn: conn} do
    conn = post conn, account_path(conn, :create), account: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, account_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some email",
      "password_digest" => "some password_digest"}
  end

  test "does not create account and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, account_path(conn, :create), account: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen account and renders account when data is valid", %{conn: conn} do
    %Account{id: id} = account = fixture(:account)
    conn = put conn, account_path(conn, :update, account), account: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, account_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "email" => "some updated email",
      "password_digest" => "some updated password_digest"}
  end

  test "does not update chosen account and renders errors when data is invalid", %{conn: conn} do
    account = fixture(:account)
    conn = put conn, account_path(conn, :update, account), account: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen account", %{conn: conn} do
    account = fixture(:account)
    conn = delete conn, account_path(conn, :delete, account)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, account_path(conn, :show, account)
    end
  end
end
