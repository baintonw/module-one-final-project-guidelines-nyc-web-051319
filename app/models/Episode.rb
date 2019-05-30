class Episode < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  def self.highest_rated
    View.all.where(rating: 5)
  end


  def self.episode_list
    self.all.map do |ep|
      ep.name
    end
  end###ADDED

  def episode_ratings
    self.views.map do |ep|
      ep.rating
    end
  end

  def episode_avg
    episode_ratings.inject { |sum, el| sum + el }.to_f / episode_ratings.size
  end

  def self.hash_name_rating
    hash = {}
      all.each do |ep|
        if ep.views != []
          hash[ep.name] = ep.episode_avg
        end
      end
    # ITERATE OVER ALL episodes
    # FOR EACH EPISODE WE NEED TO RUN THE EPISODE_AVG METHOD
    # ADD THE EPISODE NAME TO THE HASH WITH A VALUE OF THE EPISODE AVERAGE
    # View.all.each do |ep|
    #   binding.pry
    #   hash[ep.name] = rating.avg
    # end
    hash
  end


  # Need a list of viewers
  # How do we connect new Episode to show?

end #end class
