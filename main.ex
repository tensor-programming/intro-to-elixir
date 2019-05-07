defmodule Playground do
  def extract_user(user) do
    with {:ok, login} <- extract_login(user),
         {:ok, email} <- extract_email(user),
         {:ok, password} <- extract_password(user) do
      {:ok, %{login: login, email: email, password: password}}
    end
  end

  defp extract_login(%{"login" => login}), do: {:ok, login}
  defp extract_login(_), do: {:error, "login missing"}
  defp extract_email(%{"email" => email}), do: {:ok, email}
  defp extract_email(_), do: {:error, "email missing"}
  defp extract_password(%{"password" => password}), do: {:ok, password}
  defp extract_password(_), do: {:error, "password missing"}
end

# def extract_user(user) do
#   case extract_login(user) do
#     {:error, reason} ->
#       {:error, reason}

#     {:ok, login} ->
#       case extract_email(user) do
#         {:error, reason} ->
#           {:error, reason}

#         {:ok, email} ->
#           case extract_password(user) do
#             {:error, reason} ->
#               {:error, reason}

#             {:ok, password} ->
#               %{login: login, email: email, password: password}
#           end
#       end
#   end
# end

# defmodule Playground do
#   # def max(a, b) do
#   #   if a >= b, do: a, else: b
#   # end

#   # def max(a, b) do
#   #   unless a >= b, do: b, else: a
#   # end

#   # def max(a, b) do
#   #   cond do
#   #     a >= b -> a
#   #     true -> b
#   #   end
#   # end

#   # def max(a, b) when a >= b do
#   #   a
#   # end

#   # def max(a, b) do
#   #   b
#   # end

#   # def max(a, b) do
#   #   case a >= b do
#   #     true -> a
#   #     false -> b
#   #     _ -> :error
#   #   end
#   # end

# end

# defmodule Playground do
#   def test(x) when is_number(x) and x < 0 do
#     :negative
#   end

#   def test(0), do: :zero

#   def test(x) when is_number(x) and x > 0 do
#     :positive
#   end
# end

# defmodule Playground do
#   def smallest(list) when length(list) > 0 do
#     Enum.min(list)
#   end

#   def smallest(_), do: {:error, :invalid_argument}
# end

### number < atom < reference < function < port < pid
### < tuple < map < list < bitstring (binary)

## (==, !=, ===, !==, >, <, <=, >=)
## and, or, not, !
## (+, -, *, /)
## Kernel.is_number(term) Kernel.is_atom(term) etc
