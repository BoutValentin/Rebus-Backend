class RebusController < ApplicationController
  def random
  end

  def word
    to_cut = params[:word]
    if to_cut.nil?
      render :json => {:error => "You should provide a word for creating a rebus with it"}, status: :bad_request
    end
    @word_cut = to_cut.syllable.map do |value|
      value.gsub(/\s+/, "")
    end
    @word_cut
  end

  private 

  def parameters
    params.permit(:word)
  end
end
