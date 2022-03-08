class AuthenticationController < ApplicationController
    skip_before_action :authenticate, only: [:login]

    def login
        @user = User.find_by(username: params[:username].downcase)
        if @user
            if @user.authenticate(params[:password])
                @token = create_token({user_id: @user.id})
                render 'users/show', status: :ok
            else
                render json: { message: "Invalid credentials" }, status: :forbidden
            end
        else
            render json: { message: "You need to create an account" }, status: :forbidden
        end
    end
end
