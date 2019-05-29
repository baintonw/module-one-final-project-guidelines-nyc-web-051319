class Episode < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  def self.highest_rated
    View.find_by "rating > 4"
  ###Post.find_by "published_at < ?", 2.weeks.ago
  ###iterate through ALL views and find highest rated episode/show####
  end###might need work - only finds first episode that is rated a 5###



####list of viewers###

  # Need a list of viewers
  # How do we connect new Episode to show?
end
