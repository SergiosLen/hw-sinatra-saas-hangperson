class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses= ''
    @wrong_guesses=''

  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(guess)
    if guess=='' || guess.nil? ||  guess =~ /\W/
      raise ArgumentError.new()
    end
    guess=guess.downcase
    # if guess
    if  @guesses.include? guess or @wrong_guesses.include? guess
      return false
    # end
    elsif @word.include? guess
      @guesses << guess 
    else
      @wrong_guesses << guess  
    end

  end
  def word_with_guesses
    new = ''
    @word.each_char do | u|
      if @guesses.include? u
        new << u
      else
      new << '-' #unless  @wrong_guesses.include? u
    end
    end
    return new
  end
  def check_win_or_lose
    if @guesses.length + @wrong_guesses.length >=7
      return :lose
    end
    new = ''
    @word.each_char do | u|
      if @guesses.include? u
        new << ''
      else
        new << u
      end
    end
    if new.empty?
      return :win
    
  else
    return :play
  end
  end
end
