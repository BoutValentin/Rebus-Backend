json.partial! "users/user", user: @user
if defined?(@token)
    json.token @token
end