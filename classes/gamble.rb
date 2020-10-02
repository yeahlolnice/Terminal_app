require 'csv'

class Gamble 
    
    @@win_list = []


    def self.win_list
        return @@win_list
    end


    def initialize(bet)
        @bet = bet
        @row = CSV.parse(File.read("users.csv"), headers: true).find{|row| row["username"] == $username}
    end
    

    def self.log_bet(stake, bet_val, win_val, val_returned)
        CSV.open("betLog.csv", "a") do |csv|
            csv << [$username,stake,bet_val,win_val,val_returned] 
            csv.close
        end
    end

    def self.spin_wheel
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
        return @win_val
    end


    def gamble_num(num, bet)
        data = CSV.parse(File.read("users.csv"), headers: true)
        spin_wheel()
        if @win_val == num
            return_result = nil
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*35)
                    return_result = row
                    return_result["balance"] = new_balance
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    puts "YOU WON!!!"
                    puts "$#{bet*35}"
                    sleep 5
                    @val_returned = bet*35
                    puts "Winning Row:"
                    num = num.to_s
                    Gamble.log_bet(bet,num,@win_val,@val_returned)
                    return row
                end
            end
        else
            # system "clear"
            puts "Better luck next time!"
            puts "Winning number: #{@win_val}"
            return_result = nil
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    row["balance"] = new_balance.to_s
                    return_result = row
                    return_result["balance"] = new_balance
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = "no return"
                    sleep 2
                    Gamble.log_bet(bet,num,@win_val,@val_returned)
                    return return_result
                end
            end
        end 
    end


    def red(bet)
        system "clear"
        data = CSV.parse(File.read("users.csv"), headers: true)
        red_numbers = [1,3,5,7,9,12,14,16,18,19,21,23,25,27,30,32,34,36]
        spin_wheel()
        if red_numbers.include?(@win_val)
            return_result = nil
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i + (bet*2)
                    return_result = row
                    return_result["balance"] = new_balance
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    sleep 5
                    @val_returned = bet*2
                    Gamble.log_bet(bet,"Red","Red",@val_returned)
                    return return_result
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning color: Black"
            return_result = nil
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    return_result = row
                    return_result["balance"] = new_balance
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = "no return"
                    Gamble.log_bet(bet,"Red","Black",@val_returned)
                    sleep 4
                    return return_result
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
                    return_result = row
                    return_result["balance"] = new_balance
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = bet*2
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    Gamble.log_bet(bet,"Black","Black",@val_returned)
                    sleep 5
                    return return_result
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning color: Red"
            data.each do |row|
                if row["username"] == $username
                    new_balance = row["balance"].to_i - bet
                    return_result = row
                    return_result["balance"] = new_balance
                    row["balance"] = new_balance.to_s
                    File.write("users.csv", data) do |row|
                        row["balance"] << [new_balance]
                        File.close
                    end
                    @val_returned = "no return"
                    Gamble.log_bet(bet,"Black","Red",@val_returned)
                    sleep 4
                    return return_result
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
                    Gamble.log_bet(bet,"Odd","Odd",@val_returned)
                    sleep 5
                    return row
                end
            end
        else
            system "clear"
            puts "Better luck next time!"
            puts "Winning Number #{@win_val}"
            new_balance = @row["balance"].to_i - bet
            @row["balance"] = new_balance.to_s
            sleep 3
            File.write("users.csv", data) do |row|
                row["balance"] << [new_balance]
                File.close
            end
            @val_returned = "no return"
            Gamble.log_bet(bet,"Odd","Even",@val_returned)
            sleep 4
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
                    @val_returned = bet * 2
                    @val_returned = @val_returned.to_s
                    puts "YOU WON!!!"
                    puts "$#{bet*2}"
                    Gamble.log_bet(bet,"Even","Even",@val_returned)
                    sleep 5
                    return row
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
                    Gamble.log_bet(bet,"Even","Odd",@val_returned)
                    sleep 4
                    return row
                end
            end
        end
    end


    def self.split(split1)
        #split feature
        #2d array of table numbers
        table_array = [
            [1,2,3],
            [4,5,6],
            [7,8,9],
            [10,11,12],
            [13,14,15],
            [16,17,18],
            [19,20,21],
            [22,23,24],
            [25,26,27],
            [28,29,30],
            [31,32,33],
            [34,35,36]
        ]
        
        split_options = []
        # looping over table_array
        table_array.each_index do |y|
            # Get subarray and loop over its indexes also.
            subarray = table_array[y]
            subarray.each_index do |x|
                # Display x and y of array.
                if table_array[y][x] == split1
                    split_options << table_array[y-1][x]
                    split_options << table_array[y][x-1]
                    split_options << table_array[y+1][x]
                    split_options << table_array[y][x+1]
                end
            end
        end
        return split_options
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