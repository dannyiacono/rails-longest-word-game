require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].delete(' ')
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    response = open(url).read
    @word_hash = JSON.parse(response)
    if @letters.count(@word) != @word.length
      @result = "Sorry, but #{@word} can't be built out of #{@letters}"
    elsif @word_hash['found'] == false
      @result = "Sorry but #{@word} does not seem to be a valid English word..."
    else
      @result = "Congratulations #{@word} is a valid English word!"
    end
    @result
  end
end
