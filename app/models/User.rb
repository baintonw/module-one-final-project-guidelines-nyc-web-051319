class User < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  def update_bio(new_bio)
    # Where is bio held? Is this an accessor of some kind? Where is it initialized?
    self.bio = new_bio
  end #Works √


  def watch_episode(episode_id, rating)
    # Creates new instance of view
    # Watches a single episode of a show
    # Should this automatically ask for rating?
    # How does id of view connect to show?
    View.create(user_id: self.id, episode_id: episode_id, rating: rating)

  end

  def rate(episode_id, new_rating)
    # Updates rate for episode
    # Iterate through
    episode = select_episode(episode_id)

    episode.rating = new_rating
  end

  def hot_list
    # Adds show to queue
    # Should watching the first ep of a show auto-add it to queue? How to define first ep of a show?
  end

  def remove_view
  end

  def finish_episode # Change name to finale episode/finish show?
    # Complete show (removes show from queue)
    # Maybe: moves show from 'queue' to 'watch list'
    ###selet episode returns episode ids, return specific episode ids that match user ids####
    ####returns a list of viewed episodes####
    ##maybe add to watched list###
  end

  def most_popular
    # Iterate through ALL views and find most watched episode/show
    # Find most watched shows of all time, or find show that I (user) have watched the most episodes of?
    # Should this method be held in a different class, like show or episode/whatever "show" class belongs to?
  end

  def select_episode(ep_id)
    View.all.select do |ep|
      ep.episode_id = ep_id
    end
  end # Select by episode helper method

end # End user class
