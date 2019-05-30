class User < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  def watch_episode(episode_name, rating)
    # Creates new instance of view
    # Watches a single episode of a show
    eppy = Episode.all.find_by name: episode_name
    eppy_id = eppy.id
    View.create(user_id: self.id, episode_id: eppy_id, rating: rating, name: episode_name)###add episode name arugment###
 #
  end

  def rate(episode_name, new_rating)
    # Updates rate for episode
    # Iterate through
    viewing = View.all.find_by name: episode_name
    viewing.rating = new_rating  # Working √
  end # Works √

  def update_bio(new_bio) # FIX DIS
    self.bio = new_bio
  end # Number 4

  def remove_view(row_key) # FIX DIS
    View.delete(row_key)
  end

  # def finish_show # Change name to finale episode/finish show?
  #   Episode.find_or_create_by(name: "Chosen", season: "Season 7")
    # Complete show (removes show from queue)
    # Maybe: moves show from 'queue' to 'watch list'
    ###selet episode returns episode ids, return specific episode ids that match user ids####
    ####returns a list of viewed episodes####
    ##maybe add to watched list###
  # end

  # def most_popular
  #   # Iterate through ALL views and find most watched episode/show
  #   # Find most watched shows of all time, or find show that I (user) have watched the most episodes of?
  #   # Should this method be held in a different class, like show or episode/whatever "show" class belongs to?
  # end # Replaced with favorite episodes

  def select_episode(ep_id)
    View.all.select do |ep|
      ep.episode_id = ep_id
    end
  end # Select by episode helper method

  def find_episode(episode_id)
    View.all.find do |ep|
      ep = episode_id
    end
  end

  def episode_names
    View.all.map do |ep|
      ep.name
    end
  end

  def watched_episodes
    View.all.select do |ep|
      ep.user_id == self.id
    end
  end###ADDED

  def watched_episodes_names
    watched_episodes.map do |ep|
      ep.name
    end.uniq
  end###ADDED



end # End user class
