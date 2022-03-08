class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate

    def authenticate
        if request.headers["Authorization"]
            begin
                @auth_header = request.headers["Authorization"]
                decoded_token = JWT.decode(token, secret)
                payload = decoded_token.first
                user_id = payload["user_id"]
                @current_user = User.find(user_id)
            rescue => exception
                render json: {message: "You need to login to access this ressources", }, status: :forbidden   
            end
        else
            render json: {message: "No authorization header sent"}, status: :forbidden
        end
    end

    def current_user
        @current_user
    end

    def secret 
        secret = Rails.application.credentials.config[:jwt][:key]
    end

    def token
        @auth_header.split(" ")[1]
    end

    def create_token(payload)
        JWT.encode(payload, secret)
    end
end
