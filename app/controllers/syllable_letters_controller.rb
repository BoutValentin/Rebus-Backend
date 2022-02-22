class SyllableLettersController < ApplicationController
  before_action :set_syllable_letter, only: %i[ show edit update destroy ]

  # GET /syllable_letters or /syllable_letters.json
  def index
    @syllable_letters = SyllableLetter.all
  end

  # GET /syllable_letters/1 or /syllable_letters/1.json
  def show
  end

  # GET /syllable_letters/new
  def new
    @syllable_letter = SyllableLetter.new
  end

  # GET /syllable_letters/1/edit
  def edit
  end

  # POST /syllable_letters or /syllable_letters.json
  def create
    @syllable_letter = SyllableLetter.new(syllable_letter_params)

    respond_to do |format|
      if @syllable_letter.save
        format.html { redirect_to syllable_letter_url(@syllable_letter), notice: "Syllable letter was successfully created." }
        format.json { render :show, status: :created, location: @syllable_letter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @syllable_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /syllable_letters/1 or /syllable_letters/1.json
  def update
    respond_to do |format|
      if @syllable_letter.update(syllable_letter_params)
        format.html { redirect_to syllable_letter_url(@syllable_letter), notice: "Syllable letter was successfully updated." }
        format.json { render :show, status: :ok, location: @syllable_letter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @syllable_letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /syllable_letters/1 or /syllable_letters/1.json
  def destroy
    @syllable_letter.destroy

    respond_to do |format|
      format.html { redirect_to syllable_letters_url, notice: "Syllable letter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_syllable_letter
      @syllable_letter = SyllableLetter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def syllable_letter_params
      params.require(:syllable_letter).permit(:syllable_letter, :phonetic_id)
    end
end
