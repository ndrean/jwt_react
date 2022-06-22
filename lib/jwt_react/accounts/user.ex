defmodule JwtReact.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Argon2
  # import Bcrypt, only: [hash_pwd_salt: 1]

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    # Remove hash, add pw + pw confirmation
    |> cast(attrs, [:email, :password, :password_confirmation])
    # Remove hash, add pw + pw confirmation
    |> validate_required([:email, :password, :password_confirmation])
    # Check that email is valid
    |> validate_format(:email, ~r/@/)
    # Check that password length is >= 8
    |> validate_length(:password, min: 2)
    # Check that password === password_confirmation
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        # put_change(changeset, :password_hash, hash_pwd_salt(pass))
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(pass))

      # put_change(changeset, :password_hash,Argon2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
