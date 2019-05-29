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
    puts "               o
          o    |
           \\   |
            \\  |
             \\.|-.
             (\\|  )
    .==================.
    | .--------------. |
    | |--.__.--.__.--| |
    | |--.__.--.__.--| |
    | |--.__.--.__.--| |
    | |--.__.--.__.--| |
    | |--.__.--.__.--| |
    | '--------------'o|
jgs | LI LI \"\"\"\"\"\"\"   o|
    \'==================\'
    "
    puts "Please login or create a new username:"
    input0 = gets.chomp
    @user = User.find_or_create_by(name: input0)

    puts "What do you want to do today?"
    puts "Your options are:\n    watch episode, \n    change rating, \n    update favorites, \n    finish show,\n    favorite episodes,\n    remove episode,\n    exit"
    input = gets.strip

    case input

    when "watch episode" # Working √
      puts "What episode did you watch?"
      input2 = gets.strip
      puts "Give the episode a rating from 1-5."
      input3 = gets.strip
      @user.watch_episode(input2.to_s, input3.to_i)
      puts "Success! Episode watched!"
      # Ultimately, we want a user to be able to find an episode by its name rather than ID number, and we want any invalid input to be recognized by the program

    when "change rating"
      puts "Which episode do you want to change?"
      input4 = gets.strip
      puts "What is your new rating?"
      input5 = gets.strip
      @user.rate(input4.to_s, input5.to_i)
      puts "Success! Episode rating updated!"
      # Again, we want a user to be able to find an episode by its name and we want the program to deny any invalid input (i.e. rating not between 1-5)

    when "update favorites"
      puts "What is your favorite TV series?"
      fav_show = gets.strip
      @user.update_bio(fav_show.to_s)
      puts "Success! Favorite TV series updated!"

    when "finish show"
      @user.finish_show
      puts "Congratulations! You've finished an entire show! Please go outside and soak up some vitamin D before proceeding with your next television endeavor!"

    when "favorite episodes"
      # Pulls all episodes rated 5 by user
      val = @user.views.where(rating: 5)
        if val.length == 1
          bepis = val.episode_id
          puts Episode.find_by_id(bepis).name
          puts "Operation complete."
        elsif val.length > 1
          array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
          puts array2
          puts "Operation complete. You have many favorite episodes. Please learn to be more decisive."
        else
          puts "You have no favorite episodes! Please learn how to open yourself up to joy, and try again."
        end

      when "remove episode"
        puts "Which episode number would you like to delete?"
        eppy_id = gets.strip
        bepis2 = View.find_by(episode_id: eppy_id)
        View.delete(bepis2)
        # Views.where(episode_id: input6, user_id: @user)
        # @user.remove_view.where(episode_id: input6)
        puts "Operation complete!"


      when "exit"
        puts "Why would you call on me if you were just going to close me immediately? I may only be a simple CLI, but I have feelings too, and I do not like to be strung along by indicisive users like you. Think before you run next time!"

    else
      puts "Invalid input. Please try again."
    end
  end


end #end class
