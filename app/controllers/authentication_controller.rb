class AuthenticationController < ApplicationController
    skip_before_action :authenticate, only: [:login, :index]

    # GET /login
    def index 
    end

    # GET /logout
    def logout
        @current_user = nil
        cookies.delete(:auth_token)
        respond_to do |format|
            format.html {
                flash[:notice] = "You are now logout"
                redirect_to '/'
            }
            format.json { render json: {message: "You are now logout"}, status: :ok }
        end
    end

    # POST /login
    def login
        # We check if a username is provide
        if params[:username].nil? || params[:username].blank?
            respond_to do |format|
                format.html {
                    flash[:error] = "No username provide"
                    redirect_to '/login'
                }
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
                cookies[:auth_token] = @token
                # And render the show user
                respond_to do |format|
                    format.html {
                        flash[:notice] = "You are now login"
                        redirect_to '/'
                    }
                    format.json { render 'users/show', status: :ok }
                end    
            else
                # We have an incorrect credentials
                respond_to do |format|
                    format.html {
                        flash[:error] = "Invalid credentials"
                        redirect_to '/login'
                    }
                    format.json { render json: {message: "Invalid credentials"}, status: :forbidden }
                end
            end
        else
            # We have an unknow user
            respond_to do |format|
                format.html {
                    flash[:error] = "You need to create an account"
                    redirect_to '/login'
                }
                format.json { render json: {message: "You need to create an account"}, status: :forbidden }
            end
        end
    end
end
