class CommandLineInterface
#   # Creates class for CLI to keep command line actions organized
#
#   def call
#     welcome
#   end
# require_relative '../db/seeds.rb'
# require_all 'lib'
# require_all 'app'

  def welcome
    puts "Welcome to your TV Tracker!"
    puts "Please login or create a new user:"
    input0 = gets.chomp
    @user = User.find_or_create_by(name: input0)

    puts "What do you want to do today?"
    puts "Options: watch episode, update bio, finish episode, rate episode, check most popular episode"
    input = gets.strip

    case input
    when "watch episode" # Working √
      puts "What episode did you watch by id number?"
      input2 = gets.strip
      puts "Give a rating from 1-5."
      input3 = gets.strip
      @user.watch_episode(input2, input3)
      puts "Success! Episode watched!"

    when "update bio"
      puts "What is your new bio?"
      new_bio = gets.strip
      @user.update_bio(new_bio.to_s) # Current error: undefined method `update_bio' for #<CommandLineInterface:0x00007faf719e10d8>
      puts "Success! Bio updated!"

    when "finish episode"
      @user.finish_episode
      puts "Success! Episode finished!"

    when "rate"
      @user.rate
      puts "Success! Episode rated!"

    when "most popular"
      @user.most_popular
      puts "Operation complete."

    else
      puts "Invalid input. Please try again."
    end
  end


end #end class
