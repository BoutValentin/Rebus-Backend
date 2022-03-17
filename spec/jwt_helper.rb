def create_token(payload)
    JWT.encode(payload, Rails.application.credentials.config[:jwt][:key])
end