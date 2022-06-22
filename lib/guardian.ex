defmodule JwtReact.Guardian do
  use Guardian, otp_app: :jwt_react

  @doc """
  subject_for_token is used to encode the User into the token
  """
  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  @doc """
   resource_from_claims is used to rehydrate the User from the claims.
  """
  def resource_from_claims(claims) do
    %{"sub" => id} = claims
    resource = JwtReact.Accounts.get_user!(id)
    {:ok, resource}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
