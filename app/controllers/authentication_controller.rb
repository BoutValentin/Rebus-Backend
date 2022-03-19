class AuthenticationController < ApplicationController
    skip_before_action :authenticate, only: [:login]

    # POST /login
    def login
        # We check if a username is provide
        if params[:username].nil?
            respond_to do |format|
              format.json { render json: {message: "No username provide"}, status: :unprocessable_entity }
            end
            return
        end
        # We check if an user exit with this username
        @user = User.find_by(username: params[:username].downcase)
        if @user
            # We authenticate user with the password provide
            if @user.authenticate(params[:password])
                # We create a token
                @token = create_token({user_id: @user.id})
                # And render the show user
                render 'users/show', status: :ok
            else
                # We have an incorrect credentials
                render json: { message: "Invalid credentials" }, status: :forbidden
            end
        else
            # We have an unknow user
            render json: { message: "You need to create an account" }, status: :forbidden
        end
    end
end
