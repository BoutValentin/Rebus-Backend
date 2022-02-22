class PhoneticsController < ApplicationController
  before_action :set_phonetic, only: %i[ show edit update destroy ]

  # GET /phonetics or /phonetics.json
  def index
    @phonetics = Phonetic.all
  end

  # GET /phonetics/1 or /phonetics/1.json
  def show
  end

  # GET /phonetics/new
  def new
    @phonetic = Phonetic.new
  end

  # GET /phonetics/1/edit
  def edit
  end

  # POST /phonetics or /phonetics.json
  def create
    @phonetic = Phonetic.new(phonetic_params)

    respond_to do |format|
      if @phonetic.save
        format.html { redirect_to phonetic_url(@phonetic), notice: "Phonetic was successfully created." }
        format.json { render :show, status: :created, location: @phonetic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @phonetic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phonetics/1 or /phonetics/1.json
  def update
    respond_to do |format|
      if @phonetic.update(phonetic_params)
        format.html { redirect_to phonetic_url(@phonetic), notice: "Phonetic was successfully updated." }
        format.json { render :show, status: :ok, location: @phonetic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @phonetic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phonetics/1 or /phonetics/1.json
  def destroy
    @phonetic.destroy

    respond_to do |format|
      format.html { redirect_to phonetics_url, notice: "Phonetic was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_phonetic
      @phonetic = Phonetic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def phonetic_params
      params.require(:phonetic).permit(:phonetic)
    end
end
