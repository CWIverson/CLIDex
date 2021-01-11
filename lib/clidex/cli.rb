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
        input = nil
        while input != "exit"
            input = gets.strip.downcase
            if input == "exit"
                goodbye
            elsif input == "menu"
                menu
            else                
                if Type.search_by_type(input) == "invalid input" 
                    input = gets.strip.downcase
                    Type.search_by_type(input)
                else
                    checker
                end              
                puts "type the name of a pokemon you want to know more about"
                new_input = nil
                while new_input != "exit"
                    new_input = gets.strip.downcase
                    if new_input == "exit"
                        goodbye
                    elsif new_input == "menu"
                        menu
                    else
                        Pokemon.search_by_name(new_input)
                    end
                end
            end
        end
    end
    def search_by_region
        puts "What regions pokemon would you like to see?"
        input = nil
        while input != "exit" 
            input = gets.strip.downcase
            if input == "exit"
                goodbye
            elsif input == "menu"
                menu
            else               
                if Region.search_by_region(input) == nil 
                    input = gets.strip.downcase
                    Region.search_by_region(input)
                else
                    checker
                end
                puts "type the name of a pokemon you want to know more about"
                new_input = nil
                while new_input != "exit"
                    new_input = gets.strip.downcase
                    if new_input == "exit"
                        goodbye
                    elsif new_input == "menu"
                        menu
                    else
                    Pokemon.search_by_name(new_input)
                    end
                end
            end
        end
    end
end