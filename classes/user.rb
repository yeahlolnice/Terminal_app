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

    
end

