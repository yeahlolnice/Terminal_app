require 'csv'
require 'tty-prompt'
# require_relative '/classes/admin'
# require_relative '/classes/public'
require_relative 'classes/user'


prompt = TTY::Prompt.new
account_choice = 'Login or Create'
choices = %w(Login Create_account)
answer = prompt.select(account_choice, choices)
if answer == choices[0]
    loop do
        valid_user = false
        system "clear"
        puts "Username:"
        @username = gets.chomp
        puts "Password:"
        password = gets.chomp
        data = CSV.parse(File.read("users.csv"), headers: true)
        data.each do |row|
            if @username == row["username"] && password == row["password"]
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
end
if answer == choices[1]
    data = CSV.parse(File.open("users.csv", "a+"), headers: true)
    loop do
        new_user = true
        system "clear"
        puts "Username:"
        @username = gets.chomp
        puts "Password:"
        password = gets.chomp
        data.each do |row|
            if @username == row["username"]
                new_user = false
                puts "This account name exist already"
                sleep 2
            end
        end
        if new_user == true
            CSV.open("users.csv", "a") do |csv|
                csv << [@username,password,false]
                csv.close
            end
            puts "Account created: hello #{@username}"
            sleep 1
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
        data = CSV.parse(File.read("users.csv"), headers: true)
        data.each do |row|
            if row["username"] == @username
                system "clear"
                puts "Your balance is: $#{row["balance"]}"
                balance_prompt = TTY::Prompt.new
                balance_message = 'Balances menu:'
                balance_options = %w(Deposit Withdraw Cancel)
                balance_selction = balance_prompt.select(balance_message, balance_options)
                if balance_selction == balance_options[2]
                    break
                elsif balance_selction == balance_options[0]
                    puts "How much do you want to deposit?"
                    deposit = gets.chomp.to_i
                    if deposit > 0
                       puts "i should deposit money"
                       sleep 1.5
                    elsif deposit <= 0
                        puts "You must enter a number above 0"
                        sleep 1.5
                    end
                end

            end
        end
    elsif menu_selction == menu_options[3]
        system "clear"
        puts "logging out"
        sleep 2
        break
    end
end


