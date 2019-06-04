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
    # system("clear")
    # titlescreen
    login
  end


  def titlescreen
    @current_song = Audite.new
    @current_song.load('./lib/assets/song 1.mp3')
    @current_song.start_stream

    Catpix::print_image "./lib/assets/tv 6.png",
      :limit_x => 1,
      :limit_y => 1,
      :center_x => true,
      :center_y => true,
      :bg_fill => false,
      :resolution => 'high'

    sleep(3)
  end #end greet



  def login
    puts "\n       ╔═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╗ \n"
    puts "\n    🧛🏻‍  ⚰️      𝖂 𝖊𝖑𝖈𝖔𝖒𝖊  𝖙𝖔  𝕭 𝖚𝖋𝖋𝖞  𝕭 𝖚𝖉𝖉𝖎𝖊𝖘!      ⚰️  🧛🏻‍    ".colorize(:light_red).bold.blink
    puts "\n       ╚═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╝ "
    puts "\n \n     Your personalized Buffy the Vampire Slayer database!    ".colorize(:light_red)
    puts "\n \n  •  Please login or create a new username: \n".colorize(:light_red)
    input0 = gets.chomp
    if input0 == "exit"
      puts "\n       ╔═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╗ \n"
      puts "\n ⚰️   𝕰𝖓𝖉𝖎𝖓𝖌  𝖕𝖗𝖔𝖌𝖗𝖆𝖒  𝖓𝖔𝖜.  𝕴𝖋  𝖙𝖍𝖊  𝖆𝖕𝖔𝖈𝖆𝖑𝖞𝖕𝖘𝖊  𝖈𝖔𝖒𝖊𝖘,  𝖇𝖊𝖊𝖕  𝖒𝖊!  ⚰️\n  ".colorize(:red).bold
      puts "       ╚═══   ☆ .·:·. ☽ ✧    †    ✧ ☾ .·:·. ☆   ═══╝\n"
      exit("buffy")
    elsif input0 == "bepis"
      bepis_mode #easter egg
    else
      @user = User.find_or_create_by(name: input0)
      main_menu
    end
  end

  def main_menu
    puts "\n  Welcome to your personalized Buffy database, #{@user.name}!".colorize(:light_red)
    puts "\n  What do you want to do today?\n".colorize(:light_red)
    puts "      [1] start program".colorize(:light_blue)
    puts "      [2] user info".colorize(:cyan)
    puts "      [3] exit".colorize(:light_red)
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
        exit("spike")

      else
        puts "Bad dog! That is not a valid option!".colorize(:light_red)
      end
  end #end main menu

  def start_program
    #light_blue color scheme
    puts "\n  Program Menu:\n".colorize(:light_blue)
    puts "      [1] watch episode".colorize(:light_blue)
    puts "      [2] change rate".colorize(:light_black)
    puts "      [3] my top rated episodes".colorize(:light_blue)
    puts "      [4] remove view".colorize(:light_black)
    puts "      [5] top rated episodes of all time".colorize(:light_blue)
    puts "      [6] main menu".colorize(:light_black)
    puts "      [7] exit".colorize(:light_blue)
    program_input = gets.chomp
    case program_input

        when "1", "watch episode" # Working √
        puts "  List of available episodes:\n".colorize(:light_blue)
        line_break
        puts Episode.episode_list
        line_break
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
              input4 = gets.strip
              @user.watch_episode(input2.to_s, input3.to_i, input4.to_s)
              puts "\n  Success! Episode watched!".colorize(:green)
              sleep(1)
              start_program
            elsif input3 < 1
              input3 = 1
              puts puts "\n  Rating rounded up to 1!".colorize(:light_blue)
              sleep(1)
              puts "\n  Have a sentence, even! Leave a comment about the episode:\n".colorize(:light_blue)
              input4 = gets.strip
              @user.watch_episode(input2.to_s, input3.to_i, input4.to_s)
              puts "\n  Success! Episode watched!".colorize(:green)
              sleep(1)
              start_program
            else
              puts "\n  Have a sentence, even! Leave a comment about the episode:\n".colorize(:light_blue)
              input4 = gets.strip
              @user.watch_episode(input2.to_s, input3.to_i, input4.to_s)
              puts "\n  Success! Episode watched!".colorize(:green)
              sleep(1)
              start_program
            end
          end

      when "2", "change rating"
        puts "  List of available episodes\n".colorize(:light_blue)
        line_break
        puts "#{@user.watched_episodes_names}\n"
        line_break
        puts "  Which episode do you want to change?\n".colorize(:light_blue)
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

      when "3", "my top rated episodes" #Working √
        # Pulls all episodes rated 5 by user
        fav_eps


      when "4", "remove episode"
          puts "  List of available episodes:\n".colorize(:light_blue)
          puts "#{@user.watched_episodes_names}\n"
          line_break
          puts "  Which episode would you like to delete?\n".colorize(:light_blue)
          episode = gets.strip
          bepis2 = View.find_by(name: episode)
          View.delete(bepis2)
          puts "\n  Operation complete!\n  You burned down the gymnasium!\n".colorize(:green)
          sleep(2)
         start_program

      when "5", "top rated of all time"
        puts "        Top 5 Highest-Rated Episodes of all time:\n".colorize(:light_blue)
        line_break
        puts Episode.hash_name_rating.sort.first(5)
        puts " "
        line_break
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
        exit("buffy")

      else
        puts "\n  That is not an option! Once more, with feeling!\n".colorize(:light_red)
        start_program
      end
    end

  def user_info
    puts "\n  User Menu: ".colorize(:cyan)
    puts "      [1] my user data".colorize(:cyan)
    puts "      [2] my reviewed episodes".colorize(:light_black)
    puts "      [3] ep info".colorize(:cyan)
    puts "      [4] my favorite episodes".colorize(:light_black)
    puts "      [5] make or change bio".colorize(:cyan)
    puts "      [6] main menu".colorize(:light_black)
    puts "      [7] exit".colorize(:cyan)
    user_input = gets.chomp

    case user_input

    when "1", "my user data"
      sleep(1)
      puts " "
      line_break
      puts "  Username: \n".colorize(:cyan)
      puts "      #{@user.name}\n \n"
      puts "  Your episode list: \n".colorize(:cyan)
      @user.watched_episodes_names.each { |x| puts "    -  #{x}" }
      puts "\n  User bio: ".colorize(:cyan)
      puts "      #{@user.bio} \n \n"
      line_break
      sleep(3)
      user_info

    when "2", "my viewed episodes"
      line_break
      puts "  Your watched episodes: \n".colorize(:cyan)
      @user.watched_episodes_names.each { |x| puts "    -  #{x}" }
      line_break
      sleep(2)
      user_info

    when "3", "ep info"
      @user.user_ep_info
      sleep(3)
      user_info

    when "4", "my favorite episodes"
      # Not dry, fix later
      sleep(1)
      fav_eps

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
      exit("tara")

    else
      puts "  That is not a valid option!".colorize(:light_red)
    end
  end

  # def error(type)
  #   case type
  #
  #   when "invalid option"
  #   when
  #   when
  #
  #   end
  # end
  def line_break
    puts "        ━━━━━━━ ༻  ★  ༺  ━━━━━━━\n\n"
  end

  def exit(char)
    case char
    when "buffy"
      Catpix::print_image "./lib/assets/buffy.png",
        :limit_x => 1,
        :limit_y => 1,
        :center_x => true,
        :center_y => true,
        :bg_fill => false,
        :resolution => 'high'

    when "spike"
      Catpix::print_image "./lib/assets/spike.png",
        :limit_x => 1,
        :limit_y => 1,
        :center_x => true,
        :center_y => true,
        :bg_fill => false,
        :resolution => 'high'

    when "tara"
        Catpix::print_image "./lib/assets/tara.png",
          :limit_x => 1,
          :limit_y => 1,
          :center_x => true,
          :center_y => true,
          :bg_fill => false,
          :resolution => 'high'

    end
  end

  def fav_eps
    val = @user.views.where(rating: 5)
      if val.length > 0
        line_break
        puts "  Your favorite episode(s) are: "
        array2 = val.all.map { |view| Episode.find_by_id(view.episode_id).name }
        array2.each { |x| puts "    - #{x}"}
        puts " "
        line_break
        puts "    Operation complete. You have many favorite episodes. You must be a big fan of the show!\n".colorize(:green)
        puts "  Restarting program now.".colorize(:light_blue)
        sleep(4)
        start_program
      else
        puts "  You have no favorite episodes! What is your childhood trauma?\n".colorize(:light_blue)
        sleep(3)
        start_program
      end
  end

  def bepis_mode #easter egg do not touch
    # @current_song.stop_stream
    @current_song = Audite.new
    @current_song.load('./lib/assets/eastereggs/bepis mode 1.mp3')
    @current_song.start_stream

    # Catpix::print_image "./lib/assets/eastereggs/bepis.jpg",
    #   :limit_x => 1,
    #   :limit_y => 1,
    #   :center_x => true,
    #   :center_y => true,
    #   :bg_fill => false,
    #   :resolution => 'high'

    @colorizer = Lolize::Colorizer.new

    300.times do
      @colorizer.write "88                                 88
88                                 \"\"
88
88,dPPYba,   ,adPPYba, 8b,dPPYba,  88 ,adPPYba,
88P'    \"8a a8P_____88 88P\'    \"8a 88 I8[    \"\"
88       d8 8PP\"\"\"\"\"\"\" 88       d8 88  `\"Y8ba,
88b,   ,a8\" \"8b,   ,aa 88b,   ,a8\" 88 aa    ]8I
8Y\"Ybbd8\"\'   `\"Ybbd8\"\' 88`YbbdP\"\'  88 `\"YbbdP\"\'
                       88
                       88
".blink

    sleep(1)
    end #end bepis loop


  end #end bepis mode



end #class end


  # def speak
  #   system('say "hello master"')
  # end

  # def song
  #   song = Music.new('./lib/assets/song.mp3')
  #   song.volume = 50
  #   song.play
  #   sleep(100)
  # end
