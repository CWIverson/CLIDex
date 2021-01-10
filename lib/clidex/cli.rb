require_relative 'pokemon.rb'
require_relative 'type.rb'
require_relative 'region.rb'
class Clidex::CLI
    def call
        greeting
        menu
        
    end
    def greeting
        puts <<-DOC 

        Welcome to CLIDex!
        DOC
    end
    def menu
        puts <<-DOC

        What would you like to do?

            1. What is CLIDex?
            2. Search by name.
            3. Search by type.
            4. Search by region.
            5. Explain the menu options

        Enter a number to select a menu option or type exit.

        Type menu at anytime to return here.
        DOC
        input = nil
        while input != "exit"
            input = gets.strip.downcase
            case input
            when "1"
                puts "explanation text"

            when "2"
                search_by_name
            when "3"         
                search_by_type
            when "4"
                search_by_region
            when "5"
                puts "menu explanation"
            when "menu"
                menu
            when "exit"
                goodbye
               
            else
                puts "Invalid input. Type menu to return."
            end
        end
    end
    def goodbye
        puts "Thank you for using CLIDex!"
        exit
    end
    def search_by_name
        puts "What's the name of the pokemon you would like to search?"
        input = nil
        while input != "exit"
            input = gets.strip.downcase 
            if input == "menu"
                menu
            elsif input == "exit"
                goodbye
            else
                Pokemon.search_by_name(input)
            end
            
        end
        goodbye
    end
    def search_by_type
        puts "What type of pokemon would you like to search for?"
        input = gets.strip.downcase
        if input == "exit"
            goodbye
        elsif input == "menu"
            menu
        elsif input == "region"
            search_by_region
        elsif input == "name"
            search_by_name
        else
            Type.search_by_type(input)
            search_by_type
        end
         
    end
    def search_by_region
        puts "What regions pokemon would you like to see?"
        input = gets.strip.downcase
        if input == "exit"
            goodbye
        elsif input == "menu"
            menu
        elsif input == "name"
            search_by_name
        elsif input == "type"
            search_by_type
        else
            #puts "test"
            return_value = Region.search_by_region(input)
            puts return_value
            search_by_region
        end
        
    end
end