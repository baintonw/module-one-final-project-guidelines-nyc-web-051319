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
    Catpix::print_image "./lib/assets/tv 6.png",
      :limit_x => 1,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg_fill => false,
      :resolution => 'high'
  end

  def welcome

    puts "📺  Welcome to Buffy Buddies!  📺".colorize(:red).blink

    puts "\n Your personalized Buffy the Vampire Slayer database!".colorize(:red)
    puts " "
    puts "Please login or create a new username: \n"
    input0 = gets.chomp
    if input0 == "exit"
      puts "\n Ending program now. If the apocalypse comes, beep me! \n".colorize(:red)
    else
      @user = User.find_or_create_by(name: input0)
      puts "What do you want to do today?"
      puts "Your options are:\n    a. user info, \n    1. watch episode, \n    2. change rating, \n    3. create biography, \n    4. finish show (DON'T PICK THIS ONE!!!),\n    5. favorite episodes,\n    6. remove episode,\n    7. exit \n"
      input = gets.strip

      case input

      when "a", "user info" #nworking √
        puts "Username: \n    #{@user.name}\n \n"
        puts "Your episode list: "
        @user.watched_episodes_names.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
        puts " "
        puts "User bio: \n    #{@user.bio}\n"

      when "1", "watch episode" # Working √
      puts "List of available episodes:"
      puts Episode.episode_list
      puts " "
      puts " "
      puts "What episode did you watch?"
      input2 = gets.strip
      if
        @user.watched_episodes_names.include?(input2)
        puts "Bad dog! You can't review something twice. Try 'change rating' instead."
        sleep(2)
        welcome
      else
        puts "Give the episode a rating from 1-5."
        input3 = gets.strip.to_i
        if input3 > 5 || input3 < 1
          puts "Invalid input. Please choose a number between 1 and 5."
        else
          @user.watch_episode(input2.to_s, input3.to_i)
          puts "Success! Episode watched!"
        end
      end

      when "2", "change rating"
      puts "List of available episodes"
      puts " "
      puts @user.watched_episodes_names
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
      end # Working √

    when "3", "create biography" #not saving bio
        puts "Tell us about yourself. How old are you? Who is your favorite Buffy character? What is your favorite episode?"
        bio = gets.strip
        @user.update_attributes(:bio => bio.to_s)
        puts "Bio created: \n".colorize(:green)
        puts @user.bio
        puts " "
        puts "Success!".colorize(:green)
        sleep(2)



      # when "4", "finish show"
      #   @user.finish_show
      #   puts "Congratulations! You've finished the best show of all time!".colorize(:green)

      when "5", "favorite episodes" # Working √
      # Pulls all episodes rated 5 by user
      val = @user.views.where(rating: 5)
        if val.length == 1
          bepis = val.episode_id
          puts Episode.find_by_id(bepis).name
          puts "Operation complete."
        elsif val.length > 1
          array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
          array2.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
          puts "Operation complete. You have many favorite episodes. Please learn to be more decisive."
        else
          puts "You have no favorite episodes! Please learn how to open yourself up to joy, and try again."
        end

      when "6", "remove episode" #Working √
        puts "List of available episodes"
        puts " "
        puts @user.watched_episodes_names
        puts " "
        puts "Which episode would you like to delete?"
        episode = gets.strip
        bepis2 = View.find_by(name: episode)
        View.delete(bepis2) # Wo
        # Views.where(episode_id: input6, user_id: @user)
        # @user.remove_view.where(episode_id: input6)
        puts "Operation complete!"


      when "7", "exit"
        puts "Ending program now. If the apocalypse comes, beep me!".colorize(:red)

      else
        puts "Invalid input. Please try again.".colorize(:red)
        puts
        puts " "
        sleep(2)
        welcome
      end

    end # end if/then for username

  end # end welcome method


end #end class
