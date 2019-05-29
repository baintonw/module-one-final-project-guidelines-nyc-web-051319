class CommandLineInterface
  # Creates class for CLI to keep command line actions organized

  def call
    welcome
  end


  def welcome # Working, kinda
    puts "Welcome to your TV Tracker!"
    puts "What do you want to do today?"
    puts "Options: update bio, watch episode, finish episode, rate episode, check most popular episode"
    input = gets.strip

    case input
    when "update bio"
      puts "What is your new bio?"
      new_bio = gets.strip
      update_bio(new_bio.to_s) # Current error: undefined method `update_bio' for #<CommandLineInterface:0x00007faf719e10d8>
      puts "Success! Bio updated!"
    when "watch episode"
      watch_episode
      puts "Success! Episode watched!"
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
