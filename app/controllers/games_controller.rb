require "open-uri"

class GamesController < ApplicationController

  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle!
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)

    # @score = "I dont know"
    # raise
  end

  private

  def included?(word, letters)
    # .chars splits the word into an array of the letters
    # Check if the word includes the letters given
    #word -> entered word
    # letters -> array of 10 letters
    # word.split('')
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }

  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end



end
# letters = %w( c a b i n e)

# word = "cabin"
# # word = "cab"
# # p word.count
# p letters.count
# p word.count("a")
# p letters.count("c")


# # { |letter| word.count(letter) <= letters.count(letter) }
