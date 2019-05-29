class CommandLineInterface

  require 'catpix'
#   # Creates class for CLI to keep command line actions organized
#
#   def call
#     welcome
#   end
# require_relative '../db/seeds.rb'
# require_all 'lib'
# require_all 'app'
  def greet
    Catpix::print_image "./lib/buffy.png",
      :limit_x => 1,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg_fill => false,
      :resolution => 'high'
  end


  def welcome

    puts "📺  Welcome to Buffy Buddies!  📺".colorize(:red).blink
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
    puts "Your options are:\n    1. watch episode, \n    2. change rating, \n    3. update favorites, \n    4. finish show,\n    5. favorite episodes,\n    6. remove episode,\n    7. exit"
    input = gets.strip

    case input

    when "1", "watch episode" # Working √
      puts "List of available episodes:"
      puts Episode.episode_list
      puts " "
      puts " "
      puts "What episode did you watch?"
      input2 = gets.strip
      puts "Give the episode a rating from 1-5."
      input3 = gets.strip.to_i
      if input3 > 5 || input3 < 1
        puts "Invalid input. Please choose a number between 1 and 5."
      else
        @user.watch_episode(input2.to_s, input3.to_i)
        puts "Success! Episode watched!"
      end
      # Ultimately, we want a user to be able to find an episode by its name rather than ID number, and we want any invalid input to be recognized by the program

    when "2", "change rating"
      puts "List of available episodes"
      puts " "
      puts @user.unique_rated_names
      puts " "
      puts "Which episode do you want to change?"
      input4 = gets.strip
      puts "What is your new rating?"
      input5 = gets.strip.to_i
      if input5 > 5 || input5 < 1
        puts "Invalid input. Please choose a number between 1 and 5."
      else
        @user.rate(input4.to_s, input5.to_i)
        puts "Success! Rating updated!"
      end

    when "3", "update favorites"
      puts "What is your favorite TV series?"
      fav_show = gets.strip
      @user.update_bio(fav_show.to_s)
      puts "Success! Favorite TV series updated!"

    when "4", "finish show"
      @user.finish_show
      puts "Congratulations! You've finished an entire show! Please go outside and soak up some vitamin D before proceeding with your next television endeavor!"

    when "5", "favorite episodes"
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

      when "6", "remove episode"
        puts "Which episode number would you like to delete?"
        eppy_id = gets.strip
        bepis2 = View.find_by(episode_id: eppy_id)
        View.delete(bepis2)
        # Views.where(episode_id: input6, user_id: @user)
        # @user.remove_view.where(episode_id: input6)
        puts "Operation complete!"


      when "7", "exit"
        puts "Why would you call on me if you were just going to close me immediately? I may only be a simple CLI, but I have feelings too, and I do not like to be strung along by indicisive users like you. Think before you run next time!"

    else
      puts "Invalid input. Please try again."
    end
  end


end #end class
