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

  def call
    # titlescreen
    login
  end


  def titlescreen
    player = Audite.new
    player.load('./lib/assets/song.mp3')
    player.start_stream

    Catpix::print_image "./lib/assets/tv 6.png",
      :limit_x => 1,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg_fill => false,
      :resolution => 'high'

    sleep(5)
  end #end greet

  def smg
    Catpix::print_image "./lib/assets/buffy.png",
      :limit_x => 1,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg_fill => false,
      :resolution => 'high'
    end

    def tara
      Catpix::print_image "./lib/assets/tara.png",
        :limit_x => 1,
        :limit_y => 1,
        :center_x => true,
        :center_y => true,
        :bg_fill => false,
        :resolution => 'high'
      end

  def login

    puts "\n \n     📺  Welcome to Buffy Buddies! 📺      ".colorize(:light_red).blink
    puts "\n \n  \\( •_•)_†     \\( •_•)_†    \\( •_•)_†    \\( •_•)_†     \\( •_•)_†    "
    puts "\n \n     Your personalized Buffy the Vampire Slayer database!    ".colorize(:light_red)
    puts "\n \nPlease login or create a new username: \n \n".colorize(:light_red)
    input0 = gets.chomp
    if input0 == "exit"
      puts "\n Ending program now. If the apocalypse comes, beep me! \n".colorize(:light_red)
    else
      @user = User.find_or_create_by(name: input0)
      main_menu
    end
  end

  def main_menu
    puts "\nWelcome to your Buffy database, #{@user.name}!\n".colorize(:red)
    puts "\nWhat do you want to do today?\n"
    puts "    1. start program \n    2. user info \n    3. exit"
    input = gets.strip

      case input
      when "1", "start program"
        start_program

      when "2", "user info"
        puts "User start"
        user_info
      when "3", "exit"
        puts "\n Ending program now. If the apocalypse comes, beep me! \n".colorize(:red)
      else
        puts "That is not a valid option!"
      end
  end #end main menu

  def start_program
    puts "Program start!".colorize(:magenta)
    smg
    puts "    1. watch episode,\n    2. change rate,\n    3. my views,\n    4. my fav,\n    5. remove view,\n    6. top all time,\n    7. main menu\n    8. exit".colorize(:magenta)
    program_input = gets.chomp
    case program_input

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
          sleep(1)
          start_program
        elsif Episode.episode_list.include?(input2) == false
          puts "Bad dog! #{input2} is not the name of a Buffy episode! Try again!"
          sleep(3)
          start_program
        else
          puts "Give the episode a rating from 1-5."
          input3 = gets.strip.to_i
          if input3 > 5 || input3 < 1
            puts "Invalid input. Please choose a number between 1 and 5."
            sleep(1)
            start_program
          else
            puts "Leave a comment about the episode:"
            input4 = gets.strip
            @user.watch_episode(input2.to_s, input3.to_i, input4.to_s)
            puts "Success! Episode watched!"
            sleep(1)
            start_program
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
        if input5 > 5 || input5 < 1 # Fix this
          puts "Invalid input. Please choose a number between 1 and 5."
          sleep(1)
          start_program
        else
          @user.rate(input4.to_s, input5.to_i)
          puts "Success! Rating updated!"
          sleep(1)
          #Option, return to main menu or exit program
          start_program
        end # Working √

      when "3", "my views" # FIX DIS
        puts @user.views #still shows user
        start_program

      when "4", "my favs" #Working √
        # Pulls all episodes rated 5 by user
        val = @user.views.where(rating: 5)
          if val.length == 1
            bepis = val.episode_id
            puts Episode.find_by_id(bepis).name
            puts "Operation complete."
            sleep(1)
            start_program
          elsif val.length > 1
            array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
            array2.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
            puts "Operation complete. You have many favorite episodes. Please learn to be more decisive."
            sleep(1)
            start_program
          else
            puts "You have no favorite episodes! Please learn how to open yourself up to joy, and try again."
            sleep(1)
            start_program
          end

      when "5", "remove episode"
          puts "List of available episodes:"
          puts " "
          puts @user.watched_episodes_names
          puts " "
          puts "Which episode would you like to delete?"
          episode = gets.strip
          bepis2 = View.find_by(name: episode)
          View.delete(bepis2)
          puts "Operation complete!"
          sleep(2)
        start_program

      when "6", "top 5 eps all time" # FIX DIS
        puts Episode.hash_name_rating.sort.first(5)
        start_program

      when "7", "main menu"
        puts "returning to main menu"
        main_menu

      when "8", "exit"
        puts "\n Ending program now. If the apocalypse comes, beep me! \n".colorize(:red)

      else
        puts "This is not an option!"
      end
    end

  def user_info
    puts "User start"
    tara
    puts "    1. my user data\n    2. my viewed episodes\n    3. my favorite episodes\n    4. make or change bio\n    5. main menu\n    6. exit\n"
    user_input = gets.chomp

    case user_input

    when "1", "my user data"
      puts "Username: \n    #{@user.name}\n \n"
      puts "Your episode list: "
      @user.watched_episodes_names.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
      puts " "
      puts "User bio: \n    #{@user.bio}\n"
      sleep(3)
      user_info

    when "2", "my viewed episodes"
      @user.watched_episodes_names.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
      user_info

    when "3", "my favorite episodes"
      # Not dry, fix later
      val = @user.views.where(rating: 5)
        if val.length == 1
          bepis = val.episode_id
          puts Episode.find_by_id(bepis).name
          puts "Operation complete."
          sleep(1)
          user_info
        elsif val.length > 1
          array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
          array2.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
          puts "Operation complete. You have many favorite episodes. Please learn to be more decisive."
          sleep(1)
          user_info
        else
          puts "You have no favorite episodes! Please learn how to open yourself up to joy, and try again."
          sleep(1)
          user_info
        end

    when "4", "make or change bio"
        puts "Tell us about yourself. How old are you? Who is your favorite Buffy character? What is your favorite episode?"
        bio = gets.strip
        @user.update_attributes(:bio => bio.to_s)
        puts "Bio created: \n".colorize(:green)
        puts @user.bio
        puts " "
        puts "Success!".colorize(:green)
        sleep(2)
      user_info

    when "5", "main menu"
      puts "returning to main menu"
      main_menu

    when "6", "exit"
      puts "\n Ending program now. If the apocalypse comes, beep me! \n".colorize(:red)

    else
      puts "Not an option!"
    end
  end


end #class end


      # when "a", "user info" #nworking √
      #   puts "Username: \n    #{@user.name}\n \n"
      #   puts "Your episode list: "
      #   @user.watched_episodes_names.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
      #   puts " "
      #   puts "User bio: \n    #{@user.bio}\n"
      #   sleep(3)
      #   menu
      #
      #
      # when "3", "create biography" #not saving bio
      #   puts "Tell us about yourself. How old are you? Who is your favorite Buffy character? What is your favorite episode?"
      #   bio = gets.strip
      #   @user.update_attributes(:bio => bio.to_s)
      #   puts "Bio created: \n".colorize(:green)
      #   puts @user.bio
      #   puts " "
      #   puts "Success!".colorize(:green)
      #   sleep(2)
      #   menu
      #
      # when "5", "favorite episodes" # Working √
      # # Pulls all episodes rated 5 by user
      # val = @user.views.where(rating: 5)
      #   if val.length == 1
      #     bepis = val.episode_id
      #     puts Episode.find_by_id(bepis).name
      #     puts "Operation complete."
      #     sleep(1)
      #     menu
      #   elsif val.length > 1
      #     array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
      #     array2.each { |x| puts "    -  #{}".colorize(:light_blue) + x.colorize(:light_blue) }
      #     puts "Operation complete. You have many favorite episodes. Please learn to be more decisive."
      #     sleep(1)
      #     menu
      #   else
      #     puts "You have no favorite episodes! Please learn how to open yourself up to joy, and try again."
      #     sleep(1)
      #     menu
      #   end
      #
      # when "6", "remove episode" #Working √
      #   puts "List of available episodes"
      #   puts " "
      #   puts @user.watched_episodes_names
      #   puts " "
      #   puts "Which episode would you like to delete?"
      #   episode = gets.strip
      #   bepis2 = View.find_by(name: episode)
      #   View.delete(bepis2) # Wo
      #   # Views.where(episode_id: input6, user_id: @user)
      #   # @user.remove_view.where(episode_id: input6)
      #   puts "Operation complete!"
      #   sleep(2)
      #   menu
      #
      # else
      #   puts "Invalid input. Please try again.".colorize(:red)
      #   puts
      #   puts " "
      #   sleep(1)
      #   menu
      # end


  #   end # end if/then for username
  #
  # end # end welcome method
  #
  # def speak
  #   system('say "hello master"')
  # end

  # def invalid
  #   puts "Invalid input. Please try again.".colorize(:red)
  #   puts " "
  #   sleep(1)
  #   main_menu
  # end
  #
  # def exit
  #   puts "Ending program now. If the apocalypse comes, beep me!".colorize(:red)
  # end

  # def song
  #   song = Music.new('./lib/assets/song.mp3')
  #   song.volume = 50
  #   song.play
  #   sleep(100)
  # end

  # def watch_episode
  # episode = gets.strip
  # case episode
  # when "1", "watch episode" # Working √
  #   puts "List of available episodes:"
  #   puts Episode.episode_list
  #   puts " "
  #   puts " "
  #   puts "What episode did you watch?"
  #   input2 = gets.strip
  #   if
  #     @user.watched_episodes_names.include?(input2)
  #     puts "Bad dog! You can't review something twice. Try 'change rating' instead."
  #     sleep(1)
  #     start_program
  #   elsif Episode.episode_list.include?(input2) == false
  #     puts "Bad dog! #{input2} is not the name of a Buffy episode! Try again!"
  #     sleep(3)
  #     start_program
  #   else
  #     puts "Give the episode a rating from 1-5."
  #     input3 = gets.strip.to_i
  #     if input3 > 5 || input3 < 1
  #       puts "Invalid input. Please choose a number between 1 and 5."
  #       sleep(1)
  #       start_program
  #     else
  #       puts "Leave a comment about the episode:"
  #       input4 = gets.strip
  #       @user.watch_episode(input2.to_s, input3.to_i, input4.to_s)
  #       puts "Success! Episode watched!"
  #       sleep(1)
  #       start_program
  #     end
  #   end
  # end #end watch_episode
  # end

# end # end class
