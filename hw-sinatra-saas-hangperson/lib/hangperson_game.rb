class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(word)
    throw :ArgumentError unless word
    throw :ArgumentError if word.empty?
    throw :ArgumentError unless letter? word

    word.downcase!
    if @word.include? word
      return false if @guesses.include? word
      @guesses += word
    else
      return false if @wrong_guesses.include? word
      @wrong_guesses += word
    end
  end

  def word_with_guesses
    result = ""
    @word.each_char do |letter|
      result << letter if @guesses.include? letter
      result << '-' unless @guesses.include? letter
    end
    return result
  end

  def check_win_or_lose
    is_win = true
    @word.each_char do |letter|
       is_win &&= @guesses.include? letter
    end
    return :win if is_win && !@word.empty?
    return :play if @wrong_guesses.length < 7
    return :lose
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

  private
  def letter?(lookAhead)
    lookAhead =~ /[[:alpha:]]/
  end

  def each_char
    self.split("").each { |i| yield i }
  end

end
