class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :authenticate, only: [:create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /leaderboard
  def leaderboard
    @users = User.order(points: :desc).limit(100)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    params = user_params
    if params[:username].nil?
      respond_to do |format|
        format.json { render json: {message: "No username provide"}, status: :unprocessable_entity }
      end
      return
    end
    params[:username] = params[:username].downcase
    @user = User.new(params)
    @token = create_token({user_id: @user.id})
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
