class User < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  def update_bio(new_bio)
    # Where is bio held? Is this an accessor of some kind? Where is it initialized?
    self.bio = new_bio
  end #Works √


  def watch_episode
    # Creates new instance of view
    # Watches a single episode of a show
    # Should this take in an instance of an Episode, and connect that episode instance through User-View-Episode? 
    # Should this automatically ask for rating?
    # How does id of view connect to show?
    View.create
  end

  def hot_list
    # Adds show to queue
    # Should watching the first ep of a show auto-add it to queue? How to define first ep of a show?
  end

  def finish_episode # Change name to finale episode/finish show?
    # Complete show (removes show from queue)
    # Maybe: moves show from 'queue' to 'watch list'
  end

  def rate
    # Rates show
    # Should this be an initialize/automatic action?
  end

  def most_popular
    # Iterate through ALL views and find most watched episode/show
    # Find most watched shows of all time, or find show that I (user) have watched the most episodes of?
    # Should this method be held in a different class, like show or episode/whatever "show" class belongs to?
  end

end # End user class
