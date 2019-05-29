class View < ActiveRecord::Base
  # Connector between episode and user
  belongs_to :user
  belongs_to :episode

end
