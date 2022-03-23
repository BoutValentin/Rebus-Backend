# Each class who herit from the ApplicationController can use this method
class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    # Before each action, we should authenticate the user, in other word we put the authenticate
    before_action :authenticate

    # Try to authenticate an user
    def authenticate
        # We check if we have an authorization header provide
        if request.headers["Authorization"] || cookies[:auth_token]
            # We try catch the decode
            begin
                # We retrieve the value of the Authorization
                @auth_header = request.headers["Authorization"] || cookies[:auth_token]
                # We try to decode token
                decoded_token = JWT.decode(token, secret)
                # We retrieve the payload from the decode token
                payload = decoded_token.first
                # We retrieve the id from the dic payload
                user_id = payload["user_id"]
                # We try to find the current user
                @current_user = User.find(user_id)
            # On exception
            rescue => exception
                # We render an error
                respond_to do |format|
                    format.html {
                        flash[:error] = "You need to login to access this ressources"
                        redirect_to '/login'
                    }
                    format.json { render json: {message: "You need to login to access this ressources", }, status: :forbidden }
                end             
            end
        else
            # We render an error if no authorization is provide
            respond_to do |format|
                format.html {
                    flash[:error] = "You need to login"
                    redirect_to '/login'
                }
                format.json { render json: {message: "No authorization header sent"}, status: :forbidden }
            end  
        end
    end

    # Helper method who return current_user
    def current_user
        @current_user
    end

    # Retrieve the secret of the current env 
    def secret 
        secret = Rails.application.credentials.config[:jwt][:key]
    end

    # Retrieve the token from the authorization header
    def token
        # Retrieve the second element in Bearer Token
        # Authorization: Bearer <token>
        # Or we use the :auth_token
        @auth_header.split(" ")[1] || cookies[:auth_token]
    end

    # Create a token using JWT package
    def create_token(payload)
        JWT.encode(payload, secret)
    end
end
