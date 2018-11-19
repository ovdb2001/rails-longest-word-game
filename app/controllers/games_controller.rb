require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @words = params[:word]
    @letters = params[:letters]
    if english_word?(@words) && included?(@words, @letters)
      @answer = "You win"
    else
      @answer = "you lost #{@words.upcase} does not work"
    end
  end

    def english_word?(word)
      response = open("https://wagon-dictionary.herokuapp.com/#{word}")
      json = JSON.parse(response.read)
      return json['found']
    end

    def included?(guess, grid)
      guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
    end

end
