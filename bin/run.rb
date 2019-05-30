require_relative '../config/environment'
require_relative '../app/models/Episode.rb'
require_relative '../app/models/User.rb'
require_relative '../app/models/View.rb'



cli = CommandLineInterface.new
# cli.call
# binding.pry
#
# system("clear")
# cli.greet
# These two arent playing nice
# system("clear")
# cli.welcome
cli.call
# cli.song
