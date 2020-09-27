require 'csv'
require 'tty-prompt'
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
            bet_prompt = TTY::Prompt.new
            bet_message = 'Feeling lucky?'
            bet_options = %w(Number Red Black Odd Even Split Help Cancel)
            bet_selction = bet_prompt.select(bet_message, bet_options)
            if bet_selction == bet_options[0]
                system "clear"
                puts "Previous winning numbers#{$win_list}"
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


