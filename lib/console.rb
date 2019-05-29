class CommandLineInterface
#   # Creates class for CLI to keep command line actions organized
#
#   def call
#     welcome
#   end
# require_relative '../db/seeds.rb'
# require_all 'lib'
# require_all 'app'

  def welcome # Working, kinda
    puts "Welcome to your TV Tracker!"
    puts "What do you want to do today?"
    puts "Options: update bio, watch episode, finish episode, rate episode, check most popular episode"
    input = gets.strip

    case input
    when "watch episode"
      puts "What episode did you watch by id number, and give a rating from 1-5. (Example: 2, 5)"
      input2 = gets.strip
      watch_episode(input2)
      puts "Success! Episode watched!"

    when "update bio"
      puts "What is your new bio?"
      new_bio = gets.strip
      update_bio(new_bio.to_s) # Current error: undefined method `update_bio' for #<CommandLineInterface:0x00007faf719e10d8>
      puts "Success! Bio updated!"

    when "finish episode"
      finish_episode
      puts "Success! Episode finished!"

    when "rate"
      rate
      puts "Success! Episode rated!"

    when "most popular"
      most_popular
      puts "Operation complete."

    else
      puts "Invalid input. Please try again."
    end
  end


end #end class
