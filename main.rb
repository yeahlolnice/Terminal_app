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
    puts "Username:"
    username = gets.chomp
    puts "Password:"
    password = gets.chomp
    data = CSV.parse(File.read("users.csv"), headers: true)
    data.each do |row|
        if username == row["username"] && password == row["password"]
            puts "#{row["username"]}: Logged in."
        end
    end
elsif answer == choices[1]
    puts "Username:"
    username = gets.chomp
    puts "Password:"
    password = gets.chomp
    CSV.open("user.csv", "wb", headers: true) do |csv|
    csv << [username, password, false]
    end
end



