defmodule AuthSample.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset
  alias AuthSample.Accounts.Account


  schema "accounts_accounts" do
    field :email, :string
    field :password_digest, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> put_pass_hash
  end

  defp put_pass_hash(changeset) do
    password = changeset.changes.password
    put_change(changeset, :password_digest, Comeonin.Bcrypt.hashpwsalt(password))
  end
end
