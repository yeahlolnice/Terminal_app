require 'csv'
require 'tty-prompt'
require 'rainbow'
# require_relative '/classes/admin'
# require_relative '/classes/public'
require_relative 'classes/user'
require_relative 'classes/gamble'
# row["balance"] isnt updating but csv is 

data = CSV.parse(File.read("users.csv"), headers: true)
def balanceMenu
    data = CSV.parse(File.read("users.csv"), headers: true)
    return_result = nil
    data.each do |row|
        if row["username"] == $username
            return_result = row
            system "clear"
            puts "Your balance is: $#{row["balance"]}"
            balance_prompt = TTY::Prompt.new
            balance_message = 'Balances menu:'
            balance_options = %w(Deposit Withdraw Cancel)
            balance_selction = balance_prompt.select(balance_message, balance_options)
            if balance_selction == balance_options[2]
                break
            elsif balance_selction == balance_options[0]
                # deposit section
                puts "How much do you want to deposit?"
                deposit = gets.chomp.to_i
                if deposit > 0
                    new_balance = row["balance"].to_i + deposit
                    row["balance"] = new_balance.to_s
                    puts "you now have: $#{new_balance}"
                    File.write("users.csv", data) do |row|
                        return_result["balance"] = new_balance
                        row["balance"] << [new_balance]
                        File.close
                    end
                    sleep 1
                elsif deposit == 0
                    puts "You must enter a number above 0"
                    sleep 1.5
                end
            elsif balance_selction == balance_options[1]
                #withdraw section
                loop do
                    system "clear"
                    puts "How much do you want to withdraw?"
                    withdraw = gets.chomp.to_i
                    new_balance = row["balance"].to_i - withdraw
                    if withdraw <= 0
                        puts "Enter a number greater then 0"
                        sleep 2
                    elsif new_balance < 0
                        puts "Can't withdraw more then you have!"
                        sleep 2
                    elsif new_balance >= 0
                        row["balance"] = new_balance.to_s
                        return_result["balance"] = new_balance.to_s
                        puts "you now have: $#{new_balance}"
                        File.write("users.csv", data) do |row|
                            row["balance"] << [new_balance]
                            File.close
                        end
                        sleep 2
                        break
                    end
                end
            end
        end
    end
    return return_result
end

def checkBalance
    data = CSV.parse(File.read("users.csv"), headers: true)
    data.each do |row|
        if $username == row["username"]
            balance = row["balance"].to_i
            return balance
        end
    end
end


loop do
    system "clear"
    puts Rainbow("
      /$$           /$$$$$$  /$$ /$$         /$$                    /$$   
    /$$$$$$        /$$__  $$| $$| $$        |__/                  /$$$$$$ 
   /$$__  $$      | $$  \\ $$| $$| $$         /$$ /$$$$$$$        /$$__  $$
  | $$  \\__/      | $$$$$$$$| $$| $$ /$$$$$$| $$| $$__  $$      | $$  \\__/
  |  $$$$$$       | $$__  $$| $$| $$|______/| $$| $$  \\ $$      |  $$$$$$ 
   \\____  $$      | $$  | $$| $$| $$        | $$| $$  | $$       \\____  $$
   /$$  \\ $$      | $$  | $$| $$| $$        | $$| $$  | $$       /$$  \\ $$
  |  $$$$$$/      |__/  |__/|__/|__/        |__/|__/  |__/      |  $$$$$$/
   \\_  $$_/                                                      \\_  $$_/ 
     \\__/                                                          \\__/   
                                                                          ").yellow
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

row = CSV.parse(File.read("users.csv"), headers: true).find{|row| row["username"] == $username}
if row["admin"] == "true"
    admin_prompt = TTY::Prompt.new
    admin_options = ["View_all_bets", "Highest winner""Help", "Cancel"]
    admin_selection = admin_prompt.select("Felling lucky?", admin_options)
end

loop do 
    # system "clear"
    puts Rainbow("
    /$$      /$$           /$$                                            
    | $$  /$ | $$          | $$                                            
    | $$ /$$$| $$  /$$$$$$ | $$  /$$$$$$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$ 
    | $$/$$ $$ $$ /$$__  $$| $$ /$$_____/ /$$__  $$| $$_  $$_  $$ /$$__  $$
    | $$$$_  $$$$| $$$$$$$$| $$| $$      | $$  \\ $$| $$ \\ $$ \\ $$| $$$$$$$$
    | $$$/ \\  $$$| $$_____/| $$| $$      | $$  | $$| $$ | $$ | $$| $$_____/
    | $$/   \\  $$|  $$$$$$$| $$|  $$$$$$$|  $$$$$$/| $$ | $$ | $$|  $$$$$$$
    |__/     \\__/ \\_______/|__/ \\_______/ \\______/ |__/ |__/ |__/ \\_______/
    ").green
    main_prompt = TTY::Prompt.new
    menu_message = 'Welcom to the main menu'
    menu_options = %w(Balance Make_a_bet Bet_history Exit)
    menu_selection = main_prompt.select(menu_message, menu_options)
    if menu_selection == menu_options[0]
        row = balanceMenu()
    elsif menu_selection == menu_options[1]
        #make a bet
        loop do
            system "clear"
            puts Rainbow("
            /$$$$$$$              /$$                                                      
            | $$__  $$            | $$                                                      
            | $$  \\ $$  /$$$$$$  /$$$$$$         /$$$$$$/$$$$   /$$$$$$  /$$$$$$$  /$$   /$$
            | $$$$$$$  /$$__  $$|_  $$_/        | $$_  $$_  $$ /$$__  $$| $$__  $$| $$  | $$
            | $$__  $$| $$$$$$$$  | $$          | $$ \\ $$ \\ $$| $$$$$$$$| $$  \\ $$| $$  | $$
            | $$  \\ $$| $$_____/  | $$ /$$      | $$ | $$ | $$| $$_____/| $$  | $$| $$  | $$
            | $$$$$$$/|  $$$$$$$  |  $$$$/      | $$ | $$ | $$|  $$$$$$$| $$  | $$|  $$$$$$/
            |_______/  \\_______/   \\___/        |__/ |__/ |__/ \\_______/|__/  |__/ \\______/").red
            # Bet win 
            # output 
            p row
            # p row["balance"].to_i
            puts "Current balance: $#{row["balance"]}"
            bet_prompt = TTY::Prompt.new
            bet_options = ["Number", "Red", "Black", "Odd", "Even", "Split", "Help", "Cancel"]
            bet_selection = bet_prompt.select("Felling lucky?", bet_options, per_page: 8)
            if bet_selection == bet_options[0]
                system "clear"
                puts "Previous winning numbers#{Gamble.win_list}"
                puts "Pick a number between 1 & 36 or '0' '00'"
                number = gets.chomp.to_i
                puts "How much do you want to bet?"
                    bet = gets.chomp.to_i
                    gamble = Gamble.new(bet)
                    if number > 36
                        puts "Number must be less then 36."
                        sleep 2
                    elsif number < 0
                        puts "Number must be between 1 & 36 or '0' '00'"
                        sleep 2
                    elsif bet == 0
                        puts "bet must be greater then 0"
                        sleep 2
                    elsif bet > row["balance"].to_i
                        puts "Bet exceeds balance"
                        sleep 2
                    else
                        row = gamble.gamble_num(number, bet)
                    end
                elsif bet_selection == bet_options[1]
                    #red
                    gamble = Gamble.new(bet)
                    puts "Previous winning numbers #{Gamble.win_list}"
                    puts "How much do you want to bet?"
                        print "$"
                        bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif row["balance"].to_i < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.red(bet)
                end
            elsif bet_selection == bet_options[2]
                #black
                puts "Previous winning numbers#{Gamble.win_list}"
                gamble = Gamble.new(bet)
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif row["balance"].to_i < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.black(bet)
                end
            
            elsif bet_selection == bet_options[3]
                #odd bet feature
                puts "Previous winning numbers#{Gamble.win_list}"
                gamble = Gamble.new(bet)
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif row['balance'].to_i < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.odd(bet)
                end
            elsif bet_selection == bet_options[4]
                #Even bet feature
                puts "Previous winning numbers#{Gamble.win_list}"
                gamble = Gamble.new(bet)
                puts "How much do you want to bet?"
                print "$"
                bet = gets.chomp.to_i
                if bet <= 0
                    puts "Bet must be a number above 0"
                    sleep 2
                elsif row["balance"].to_i < bet
                    puts "Bet exceeds balance"
                    sleep 2
                else
                    gamble.even(bet)
                end
            elsif bet_selection == bet_options[5]
                #split feature
                Gamble.split
            elsif bet_selection == bet_options[6]
                system "clear"
                puts "Number - bet on any number between 1 & 36 or '0' '00'"
                puts "Red - bet on all the red numbers"
                puts "Black - bet on all the black"
                puts "Odd - bet on all odd numbers"
                puts "Even - bet on all even numbers"
                puts "Split - bet on 2 numbers bedside each other"
                puts "press enter to exit"
                gets.chomp
            elsif bet_selection == bet_options[7]
                break
            end
        end
    elsif menu_selection == menu_options[2]
        #bet history
        Gamble.betHistory
    elsif menu_selection == menu_options[3]
        system "clear"
        puts "logging out"
        sleep 2
        break
    end
end


