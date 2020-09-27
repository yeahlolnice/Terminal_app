require 'csv'

class User
    def initialize(user_name, password, admin=false) 
        @user_name = user_name
        @password = password
        @admin = admin
    end

    def display
        puts "username: #{@user_name} logged in"
    end

    def balanceMenu
        data = CSV.parse(File.read("users.csv"), headers: true)
        data.each do |row|
            if row["username"] == $username
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
        
    end
end

