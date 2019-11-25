require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @letters_test = @letters

    @word.split("").each do |letter|
      if @letters_test.include?(letter)
        @letters_test = @letters_test.delete(letter)
      else
        @answer = "Sorry but #{@word} can't be build out of #{@letters}"
        return ''
      end
    end

    results = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    if results["found"]
      @answer = "Congratulations! #{@word} is a valid English word!"
    else
      @answer = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
