require 'csv'
require 'tty-prompt'
require 'rainbow'
# require_relative '/classes/admin'
# require_relative '/classes/public'
require_relative 'classes/user'
require_relative 'classes/gamble'


loop do
    system "clear"
    prompt = TTY::Prompt.new
    account_choice = 'Login or Create'
    choices = %w(Login Create_account)
    answer = prompt.select(account_choice, choices)
    if answer == choices[0]
        valid_user = false
        system "clear"
        puts "Username:"
        $username = gets.chomp
        puts "password:"
        $password = gets.chomp
        data = CSV.parse(File.read("users.csv"), headers: true)
        data.each do |row|
            if $username == row["username"] && $password == row["password"]
                puts "#{row["username"]}: Logged in."
                valid_user = true
                sleep 2
            end
        end
        if valid_user == false
            puts "Invalid username or password"
            sleep 1.5
        else
            break
        end 
    end
    if answer == choices[1]
        data = CSV.parse(File.open("users.csv", "a+"), headers: true)
        new_user = true
        system "clear"
        puts "Username:"
        $username = gets.chomp
        puts "password:"
        $password = gets.chomp
        data.each do |row|
            if $username == row["username"]
                new_user = false
                puts "This account name exist already"
                sleep 2
            end
        end
        if new_user == true
            CSV.open("users.csv", "a") do |csv|
                csv << [$username,$password,0,false]
                csv.close
            end
            puts "Account created: hello #{$username}"
            sleep 1.5
            break
        end
    end
end
loop do 
    system "clear"
    main_prompt = TTY::Prompt.new
    menu_message = 'Welcom to the main menu'
    menu_options = %w(Balance Make_a_bet Bet_history Exit)
    menu_selction = main_prompt.select(menu_message, menu_options)
    if menu_selction == menu_options[0]
        user = User.new($username, $password)
        user.balanceMenu
    elsif menu_selction == menu_options[1]
        #make a bet
        loop do
            system "clear"
            bet_prompt = TTY::Prompt.new
            bet_message = 'Feeling lucky?'
            bet_options = %w(Number Red Black Odd Even Split Help Cancel)
            bet_selction = bet_prompt.select(bet_message, bet_options)
            if bet_selction == bet_options[0]
                system "clear"
                puts "Previous winning numbers#{Gamble.win_list}"
                puts "Pick a number between 1 & 36 or '0' '00'"
                number = gets.chomp.to_i
                puts "How much do you want to bet?"
                bet = gets.chomp.to_i
                gamble = Gamble.new(bet)
                data = CSV.parse(File.read("users.csv"), headers: true)
                data.each do |row|
                    if $username == row["username"]
                        @balance = row["balance"].to_i
                    end
                end
                if number > 36
                    puts "Number must be less then 36."
                    sleep 2
                elsif number < 0
                    puts "Number must be between 1 & 36 or '0' '00'"
                    sleep 2
                elsif bet == 0
                    puts "bet must be greater then 0"
                    sleep 2
                elsif bet > @balance
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.gamble_num(number, bet)
                end
            elsif bet_selction == bet_options[1]
                #red
                gamble = Gamble.new(bet)
                puts "Previous winning numbers #{Gamble.win_list}"
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif User.checkBalance < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.red(bet)
                end
            elsif bet_selction == bet_options[2]
                #black
                puts "Previous winning numbers#{Gamble.win_list}"
                gamble = Gamble.new(bet)
                data = CSV.parse(File.read("users.csv"), headers: true)
                data.each do |row|
                    if $username == row["username"]
                        @balance = row["balance"].to_i
                    end
                end
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif @balance < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.black(bet)
                end
            elsif bet_selction == bet_options[3]
                #Even bet feature
                puts "Previous winning numbers#{Gamble.win_list}"
                gamble = Gamble.new(bet)
                data = CSV.parse(File.read("users.csv"), headers: true)
                data.each do |row|
                    if $username == row["username"]
                        @balance = row["balance"].to_i
                    end
                end
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif @balance < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.even(bet)
                end
            elsif bet_selction == bet_options[4]
                #odd bet feature
                puts "Previous winning numbers#{Gamble.win_list}"
                gamble = Gamble.new(bet)
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif User.checkBalance < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.odd(bet)
                end
            elsif bet_selction == bet_options[5]
                #split feature
                puts "#{Rainbow("1 ").bg(:red).black} #{Rainbow("2 ").bg(:black).red} #{Rainbow("3 ").bg(:red).black}" 
                puts "#{Rainbow("4 ").bg(:black).red} #{Rainbow("5 ").bg(:red).black} #{Rainbow("6 ").bg(:black).red}" 
                puts "#{Rainbow("7 ").bg(:red).black} #{Rainbow("8 ").bg(:black).red} #{Rainbow("9 ").bg(:red).black}" 
                puts "#{Rainbow(10).bg(:black).red} #{Rainbow(11).bg(:black).red} #{Rainbow(12).bg(:red).black}" 
                puts "#{Rainbow(13).bg(:black).red} #{Rainbow(14).bg(:red).black} #{Rainbow(15).bg(:black).red}" 
                puts "#{Rainbow(16).bg(:red).black} #{Rainbow(17).bg(:black).red} #{Rainbow(18).bg(:red).black}" 
                puts "#{Rainbow(19).bg(:red).black} #{Rainbow(20).bg(:black).red} #{Rainbow(21).bg(:red).black}" 
                puts "#{Rainbow(22).bg(:black).red} #{Rainbow(23).bg(:red).black} #{Rainbow(24).bg(:black).red}" 
                puts "#{Rainbow(25).bg(:red).black} #{Rainbow(26).bg(:black).red} #{Rainbow(27).bg(:red).black}" 
                puts "#{Rainbow(28).bg(:black).red} #{Rainbow(29).bg(:black).red} #{Rainbow(30).bg(:red).black}" 
                puts "#{Rainbow(31).bg(:black).red} #{Rainbow(32).bg(:red).black} #{Rainbow(33).bg(:black).red}" 
                puts "#{Rainbow(34).bg(:red).black} #{Rainbow(35).bg(:black).red} #{Rainbow(36).bg(:red).black}" 
                puts "press enter to continue"
                gets.chomp
            elsif bet_selction == bet_options[6]
                system "clear"
                puts "Number - bet on any number between 1 & 36 or '0' '00'"
                puts "Red - bet on all the red numbers"
                puts "Black - bet on all the black"
                puts "Odd - bet on all odd numbers"
                puts "Even - bet on all even numbers"
                puts "Split - bet on 2 numbers bedside each other"
                puts "press enter to exit"
                gets.chomp
            elsif bet_selction == bet_options[7]
                break
            end
        end
    elsif menu_selction == menu_options[2]
        #bet history
    elsif menu_selction == menu_options[3]
        system "clear"
        puts "logging out"
        sleep 2
        break
    end
end


