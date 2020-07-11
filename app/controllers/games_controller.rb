require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (('a'..'z').to_a).sample(10)
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @english_word = english_word?(@word)
    @included = included?(@word, @letters)
    # a.all?{|i| b.include? i }
  end

  def included?(word, letters)
    letters_of_word = word.split("")
    letters_of_word.all? { |i| @letters.include? i }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
