require 'csv'

class Gamble 
    def initialize(bet)
        @bet = bet
        @win_list = []
    end
    
    def spin_wheel
        numbers = [0,00,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
        @win_number = numbers.shuffle!.pop
        @win_list.push(@win_number)
        system "clear"
        puts "3"
        sleep 1
        puts "2"
        sleep 1
        puts "1"
        sleep 1
    end

    def gamble_num(num, bet)
        data = CSV.parse(File.read("users.csv"), headers: true)
        spin_wheel()
        if @win_number == num
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*35)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    puts "YOU WON!!!"
                    puts "$#{bet*35}"
                    sleep 5
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning number: #{@win_number}"
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                end
            end
            sleep 2
        end 
    end

    def red(bet)
        data = CSV.parse(File.read("users.csv"), headers: true)
        red_numbers = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
        puts "Winning numbers:#{@win_list}"
        p @win_list
        spin_wheel()
        sleep 0.5
        if red_numbers.include?(@win_number)
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    puts @win_list
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    sleep 5
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning color: Black"
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    sleep 4
                end
            end
        end       
    end

    def black(bet)
        data = CSV.parse(File.read("users.csv"), headers: true)
        black_numbers = [2,4,6,8,10,11,13,15,17,20,22,24,26,28,29,31,33,35]
        puts "Winning numbers:#{@win_list}"
        spin_wheel()
        sleep 0.5
        if black_numbers.include?(@win_number)
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    puts @win_list
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    sleep 5
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning color: Red"
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    sleep 4
                end
            end
        end       
    end
end