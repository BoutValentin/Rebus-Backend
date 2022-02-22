class IconsController < ApplicationController
  before_action :set_icon, only: %i[ show edit update destroy ]

  # GET /icons or /icons.json
  def index
    @icons = Icon.all
  end

  # GET /icons/1 or /icons/1.json
  def show
  end

  # GET /icons/new
  def new
    @icon = Icon.new
  end

  # GET /icons/1/edit
  def edit
  end

  # POST /icons or /icons.json
  def create
    @icon = Icon.new(icon_params)

    respond_to do |format|
      if @icon.save
        format.html { redirect_to icon_url(@icon), notice: "Icon was successfully created." }
        format.json { render :show, status: :created, location: @icon }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @icon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /icons/1 or /icons/1.json
  def update
    respond_to do |format|
      if @icon.update(icon_params)
        format.html { redirect_to icon_url(@icon), notice: "Icon was successfully updated." }
        format.json { render :show, status: :ok, location: @icon }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @icon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /icons/1 or /icons/1.json
  def destroy
    @icon.destroy

    respond_to do |format|
      format.html { redirect_to icons_url, notice: "Icon was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_icon
      @icon = Icon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def icon_params
      params.require(:icon).permit(:name, :image)
    end
end
