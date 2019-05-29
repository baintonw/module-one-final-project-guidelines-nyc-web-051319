class Episode < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  def self.highest_rated
    View.all.where(rating: 5)
  end

  


  # Need a list of viewers
  # How do we connect new Episode to show?

end #end class
