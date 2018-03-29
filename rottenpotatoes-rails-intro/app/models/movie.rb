class Movie < ActiveRecord::Base
    public
    def self.all_ratings
        return ['G','PG','PG-13','R']
    end
end
