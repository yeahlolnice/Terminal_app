require 'csv'

class Gamble 

    @@win_list = []

    def self.win_list
        @win_val = @@win_list.pop
        return @@win_list
    end

    def initialize(bet)
        @bet = bet
    end
    
    def self.logBet(bet, win_val, bet_val, val_returned)
        CSV.open("betLog.csv", "a") do |csv|
            csv << [$username,bet,bet_val,win_val,val_returned] 
            csv.close
        end
    end

    def spin_wheel
        numbers = [0,00,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
        @win_val = numbers.shuffle.pop
        @@win_list.push(@win_val)
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
        if @win_val == num
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
                    @val_returned = bet*35
                end
            end
            Gamble.logBet(bet,num,@win_val,@val_returned)
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning number: #{@win_val}"
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
            @val_returned = "no return"
            sleep 2
            Gamble.logBet(bet,num,@win_val,@val_returned)
        end 
    end

    def red(bet)
        system "clear"
        data = CSV.parse(File.read("users.csv"), headers: true)
        red_numbers = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
        spin_wheel()
        sleep 0.5
        if red_numbers.include?(@win_val)
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    puts Gamble.win_list
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    sleep 5
                end
            end
            @val_returned = bet*2
            Gamble.logBet(bet,"Red","Red",@val_returned)
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
                    @val_returned = "no return"
                    Gamble.logBet(bet,"Red","Black",@val_returned)
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
        if black_numbers.include?(@win_val)
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = bet*2
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    Gamble.logBet(bet,"Black","Black",@val_returned)
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
                    @val_returned = "no return"
                    Gamble.logBet(bet,"Black","Red",@val_returned)
                    sleep 4
                end
            end
        end       
    end

    def odd(bet)
        data = CSV.parse(File.read("users.csv"), headers: true)
        odd_numbers = [1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35]
        puts "Winning numbers:#{@win_list}"
        spin_wheel()
        if odd_numbers.include?(@win_val)
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = bet*2
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    Gamble.logBet(bet,"Odd","Odd",@val_returned)
                    sleep 5
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning Number #{@win_val}"
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = "no return"
                    Gamble.logBet(bet,"Odd","Even",@val_returned)
                    sleep 4
                end
            end
        end
    end

    def even(bet)
        data = CSV.parse(File.read("users.csv"), headers: true)
        even_numbers = [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36]
        puts "Winning numbers:#{@win_list}"
        spin_wheel()
        sleep 0.5
        if even_numbers.include?(@win_val)
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    x = bet*2.to_s
                    @val_returned = "$"+ x
                    p @val_returned
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    Gamble.logBet(bet,"Even","Even",@val_returned)
                    sleep 5
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning Number #{@win_val}"
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = "no return"
                    Gamble.logBet(bet,"Even","Odd",@val_returned)
                    sleep 4
                end
            end
        end
    end

    def self.split
        #split feature
        #prints the roulette table
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
    end

    def self.betHistory
        # admin version
        # CSV.foreach("betLog.csv", headers: true) do |row|
        #     puts "#{row["id"]} - #{row["qty"]}"
        # end
        CSV.foreach("betLog.csv", headers: true) do |row|
            if row["username"] == $username
                puts "#{row["stake"]} on #{row["bet_val"]} return: #{row["return"]} "
            end
        end
        puts "Press enter to continue"
        gets.chomp
    end
end