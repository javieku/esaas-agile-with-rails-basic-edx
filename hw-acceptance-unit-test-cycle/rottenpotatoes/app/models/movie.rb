class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
public
  def self.find_with_same_director(id)
    movie = Movie.find(id)
    Movie.where(director: movie.director)
  end
end
