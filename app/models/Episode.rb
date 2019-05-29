class Episode < ActiveRecord::Base
  has_many :views
  has_many :users, through: :views

  # Need a list of viewers
  # How do we connect new Episode to show? 
end
