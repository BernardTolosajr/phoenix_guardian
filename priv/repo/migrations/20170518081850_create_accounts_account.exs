defmodule AuthSample.Repo.Migrations.CreateAuthSample.Accounts.Account do
  use Ecto.Migration

  def change do
    create table(:accounts_accounts) do
      add :email, :string
      add :password_digest, :string

      timestamps()
    end

  end
end
