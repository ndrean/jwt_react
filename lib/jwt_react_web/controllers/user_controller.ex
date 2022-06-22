defmodule JwtReactWeb.UserController do
  use JwtReactWeb, :controller

  alias JwtReact.Accounts
  alias JwtReact.Accounts.User
  alias JwtReact.Guardian

  action_fallback JwtReactWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params} = _params) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      render(conn, "jwt.json", jwt: token)
    end

    # conn
    # |> put_status(:created)
    # |> put_resp_header("location", Routes.user_path(conn, :show, user))
    # |> render("show.json", user: user)

    # end
  end

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect(user, label: "user")
    conn |> render("user.json", user: user)
  end

  # def show(conn, %{"id" => id} = _params) do
  # user = Accounts.get_user!(id)
  # render(conn, "show.json", user: user)
  # end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Accounts.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn |> render("jwt.json", jwt: token)

      _ ->
        {:error, :unauthorized}
    end
  end
end
