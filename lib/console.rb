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
    system("clear")
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

    sleep(3)
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

    puts "\n       ╔═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╗ \n"
    puts "\n    🧛🏻‍  ⚰️      𝖂 𝖊𝖑𝖈𝖔𝖒𝖊  𝖙𝖔  𝕭 𝖚𝖋𝖋𝖞  𝕭 𝖚𝖉𝖉𝖎𝖊𝖘!      ⚰️  🧛🏻‍    ".colorize(:light_red).bold.blink
    puts "\n       ╚═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╝ "
    puts "\n \n     Your personalized Buffy the Vampire Slayer database!    ".colorize(:light_red)
    puts "\n \n  Please login or create a new username: \n".colorize(:light_red)
    input0 = gets.chomp
    if input0 == "exit"
      puts "\n Ending program now. If the apocalypse comes, beep me! \n".colorize(:light_red)
    else
      @user = User.find_or_create_by(name: input0)
      main_menu
    end
  end

  def main_menu
    puts "\n  Welcome to your personalized Buffy database, #{@user.name}!".colorize(:light_red)
    puts "\n  What do you want to do today?\n".colorize(:light_red)
    puts "      1. start program \n      2. user info \n      3. exit".colorize(:light_red)
    input = gets.strip

      case input
      when "1", "start program"
        start_program

      when "2", "user info"
        user_info

      when "3", "exit"
        puts "\n       ╔═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╗ \n"
        puts "\n ⚰️   𝕰𝖓𝖉𝖎𝖓𝖌  𝖕𝖗𝖔𝖌𝖗𝖆𝖒  𝖓𝖔𝖜.  𝕴𝖋  𝖙𝖍𝖊  𝖆𝖕𝖔𝖈𝖆𝖑𝖞𝖕𝖘𝖊  𝖈𝖔𝖒𝖊𝖘,  𝖇𝖊𝖊𝖕  𝖒𝖊!  ⚰️  \n".colorize(:red).bold
        puts "       ╚═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╝ "
        sleep(1)
        smg

      else
        puts "Bad dog! That is not a valid option!".colorize(:light_red)
      end
  end #end main menu

  def start_program
    #light_blue color scheme
    puts "\n  Program Menu:\n".colorize(:light_blue)
    puts "      1. watch episode\n      2. change rate\n      3. my favs\n      4. remove view\n      5. top five\n      6. main menu\n      7. exit\n".colorize(:light_blue)
    program_input = gets.chomp
    case program_input

        when "1", "watch episode" # Working √
        puts "  List of available episodes:\n".colorize(:light_blue)
        puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
        puts Episode.episode_list
        puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
        puts "\n  What episode did you watch?\n".colorize(:light_blue)
        input2 = gets.strip
        if
          @user.watched_episodes_names.include?(input2)
          puts "  Bad dog! You can't review something twice. Try 'change rating' instead.".colorize(:light_blue)
          sleep(1)
          start_program
        elsif Episode.episode_list.include?(input2) == false
          puts "  Bad dog! #{input2} is not the name of a Buffy episode! Try again!".colorize(:light_blue)
          sleep(1)
          start_program
        else
          puts "\n  Give the episode a rating from 1-5.\n".colorize(:light_blue)
          input3 = gets.strip.to_i
              if input3 > 5
              input3 = 5
              puts "\n  Rating rounded down to 5!".colorize(:light_blue)
              sleep(1)
              puts "\n  Have a sentence, even! Leave a comment about the episode:\n".colorize(:light_blue)
            elsif input3 < 1
              input3 = 1
              puts puts "\n  Rating rounded up to 1!".colorize(:light_blue)
              sleep(1)
              puts "\n  Have a sentence, even! Leave a comment about the episode:\n".colorize(:light_blue)
            else
              puts "\n  Have a sentence, even! Leave a comment about the episode:\n".colorize(:light_blue)
            end
            input4 = gets.strip
            @user.watch_episode(input2.to_s, input3.to_i, input4.to_s)
            puts "\n  Success! Episode watched!".colorize(:light_blue)
            sleep(1)
            start_program
          end

      when "2", "change rating"
        puts "  List of available episodes\n".colorize(:light_blue)
        puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
        puts @user.watched_episodes_names
        puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n"
        puts "\n  Which episode do you want to change?\n".colorize(:light_blue)
        input4 = gets.strip
        if @user.watched_episodes_names.include?(input4) == false
          puts "\nBad dog! That's not the name of a Buffy episode. Try again.".colorize(:light_blue)
          puts "\n  Returning to program menu.".colorize(:light_red)
          sleep(1)
          start_program
        else
          puts "\n  What is your new rating?\n".colorize(:light_blue)
          input5 = gets.strip
        end

        case input5
        when "1", "2", "3", "4", "5"
          puts "\n  Please update your review: \n".colorize(:light_blue)
          input6 = gets.strip
          @user.rate(input4.to_s, input5.to_i, input6.to_s)
          puts "\n  Success! Rating updated!".colorize(:green)
          puts puts "\n  Returning to program menu.\n".colorize(:light_blue)
          sleep(1)
          start_program
        else
          puts "\n  Invalid input. Please choose an integer number between 1 and 5.\n".colorize(:light_blue)
          puts "  Returning to program menu.\n".colorize(:light_red)
          sleep(1)
          start_program
        end # Working √

      when "3", "my favs" #Working √
        # Pulls all episodes rated 5 by user
        val = @user.views.where(rating: 5)
          if val.length > 0
            puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
            puts "  Your favorite episode(s) are: "
            array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
            array2.each { |x| puts "    - #{x}"}
            puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
            puts "\n    Operation complete. You have many favorite episodes. You must be a big fan of the show!\n".colorize(:green)
            puts "  Restarting program now.".colorize(:light_blue)
            sleep(4)
            start_program
          else
            puts "  You have no favorite episodes! What is your childhood trauma?\n".colorize(:light_blue)
            sleep(3)
            start_program
          end

      when "4", "remove episode"
          puts "  List of available episodes:\n".colorize(:light_blue)
          puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
          puts @user.watched_episodes_names
          puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
          puts "\n  Which episode would you like to delete?\n".colorize(:light_blue)
          episode = gets.strip
          bepis2 = View.find_by(name: episode)
          View.delete(bepis2)
          puts "\n  Operation complete!\n  You burned down the gymnasium!\n".colorize(:green)
          sleep(2)
         start_program

      when "5", "top five"
        puts "        Top 5 Highest-Rated Episodes of all time:\n".colorize(:light_blue)
        puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
        puts Episode.hash_name_rating.sort.first(5)
        puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
        sleep(2)
        start_program

      when "6", "main menu"
        puts "Returning to main menu.".colorize(:light_red)
        main_menu

      when "7", "exit"
        puts "\n       ╔═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╗ \n"
        puts "\n ⚰️   𝕰𝖓𝖉𝖎𝖓𝖌  𝖕𝖗𝖔𝖌𝖗𝖆𝖒  𝖓𝖔𝖜.  𝕴𝖋  𝖙𝖍𝖊  𝖆𝖕𝖔𝖈𝖆𝖑𝖞𝖕𝖘𝖊  𝖈𝖔𝖒𝖊𝖘,  𝖇𝖊𝖊𝖕  𝖒𝖊!  ⚰️  \n".colorize(:red).bold
        puts "       ╚═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╝ "
        sleep(1)
        smg

      else
        puts "\n  That is not an option! Once more, with feeling!\n".colorize(:light_red)
        start_program
      end
    end

  def user_info
    puts "\n  User Menu: ".colorize(:cyan)
    puts "      1. my user data\n      2. my viewed episodes\n      3. ep info\n      4. my favorite episodes\n      5. make or change bio\n      6. main menu\n      7. exit\n".colorize(:cyan)
    user_input = gets.chomp

    case user_input

    when "1", "my user data"
      sleep(1)
      puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
      puts "  Username: \n".colorize(:cyan)
      puts "      #{@user.name}\n \n"
      puts "  Your episode list: \n".colorize(:cyan)
      @user.watched_episodes_names.each { |x| puts "    -  #{x}" }
      puts "\n  User bio: ".colorize(:cyan)
      puts "      #{@user.bio} \n \n"
      puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
      sleep(3)
      user_info

    when "2", "my viewed episodes"
      puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
      puts "  Your watched episodes: \n".colorize(:cyan)
      @user.watched_episodes_names.each { |x| puts "    -  #{x}" }
      puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
      sleep(2)
      user_info

    when "3", "ep info"
      @user.user_ep_info
      sleep(3)
      user_info

    when "4", "my favorite episodes"
      # Not dry, fix later
      sleep(1)
      val = @user.views.where(rating: 5)
        if val.length == 1
          bepis = val.episode_id
          puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
          puts "  Your favorite episode is: #{Episode.find_by_id(bepis).name}. Good choice!\n"
          puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
          sleep(1)
          puts "\n    Operation complete. You have many favorite episodes. You must be a big fan of the show!\n".colorize(:green)
          puts "  Returning to user menu.".colorize(:cyan)
          sleep(3)
          start_program
        elsif val.length > 1
          puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
          puts "  Your favorite episodes are: \n".colorize(:cyan)
          array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
          array2.each { |x| puts "    -  " + x }
          puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
          puts "\n    Operation complete. You have many favorite episodes. You must be a big fan of the show!\n".colorize(:green)
          puts "  Returning to user menu.\n".colorize(:cyan)
          sleep(3)
          user_info
        else
          puts "You have no favorite episodes! What is your childhood trauma?!".colorize(:cyan)
          puts "  Returning to user menu.".colorize(:cyan)
          sleep(2)
          user_info
        end

    when "5", "make or change bio"
        puts "\n  Tell us about yourself.".colorize(:cyan)
        puts "    - How old are you?".colorize(:cyan)
        puts "    - Who is your favorite Buffy character?".colorize(:cyan)
        puts "    - What is your favorite episode?\n".colorize(:cyan)
        bio = gets.strip
        @user.update_attributes(:bio => bio.to_s)
        puts "\n  New Bio: ".colorize(:cyan)
        sleep(1)
        puts "\n    #{@user.bio}\n"
        puts "\n  Success!\n".colorize(:green)
        sleep(2)
      user_info

    when "6", "main menu"
      puts "\n  Returning to main menu.".colorize(:light_red)
      sleep(1)
      main_menu

    when "7", "exit"
      puts "\n       ╔═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╗ \n"
      puts "\n ⚰️   𝕰𝖓𝖉𝖎𝖓𝖌  𝖕𝖗𝖔𝖌𝖗𝖆𝖒  𝖓𝖔𝖜.  𝕴𝖋  𝖙𝖍𝖊  𝖆𝖕𝖔𝖈𝖆𝖑𝖞𝖕𝖘𝖊  𝖈𝖔𝖒𝖊𝖘,  𝖇𝖊𝖊𝖕  𝖒𝖊!  ⚰️  \n".colorize(:red).bold
      puts "       ╚═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╝ "
      sleep(1)
      tara

    else
      puts "  That is not a valid option!".colorize(:light_red)
    end
  end



end #class end

# if val.length == 1
#   bepis = val.episode_id
#   puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
#   puts "  Your favorite episode is: #{Episode.find_by_id(bepis).name}. Good choice!\n".colorize(:light_blue)
#   puts "\n        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
#   puts "  Operation complete.\n".colorize(:green)
#   puts "  Restarting program now.".colorize(:light_blue)
#   sleep(2)
#   start_program


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

  # Old header
  #puts "\n \n    🧛🏻‍  ⚰️      𝖂 𝖊𝖑𝖈𝖔𝖒𝖊  𝖙𝖔  𝕭 𝖚𝖋𝖋𝖞  𝕭 𝖚𝖉𝖉𝖎𝖊𝖘!      ⚰️  🧛🏻‍    ".colorize(:light_red).bold.blink
  # puts "\n \n  \\( •_•)_†     \\( •_•)_†    \\( •_•)_†    \\( •_•)_†     "
  #puts "

#.-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-.   .-.-
#/ / \\ \\ / / \\ \\ / / \\ \\ / / \\ \\ / / \\ \\ / / \\ \\ / / \\ \\ / / \\
#`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'   `-`-'
  #"

# end # end class
