require 'csv'

class Gamble 
    def initialize(bet)
        @bet = bet
        @win_list = []
    end
    
    def gamble_num(num, bet)
        numbers = [0,00,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,26,27,28,29,30,31,32,33,34,35,36]
        arr = [1,2]
        data = CSV.parse(File.read("users.csv"), headers: true)
        # win_number = numbers.shuffle!.pop
        win_number = arr[0]
        @win_list.push(win_number) 
        if win_number == num
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
            puts "Winning number: #{win_number}"
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
end