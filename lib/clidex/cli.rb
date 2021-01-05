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
                puts "Whats the name of the pokemon you would like to search for?"
                search_by_name
            when "3"
                puts "What pokemon type would you like to search for?"
                search_by_type
            when "4"
                puts "What region would you like to search?"
                search_by_region
            when "5"
                puts "menu explanation"

            when "menu"
                menu
            when "exit"
                goodbye
                exit
            else
                puts "Invalid input. Type menu to return."
            end
        end
    end
    def goodbye
        puts "Thank you for using CLIDex!"
    end
    def search_by_name
        input = nil
        while input != "exit"
            input = gets.strip.downcase
            case input
            when "pikachu"
                puts "electric mouse pokemon"
            when "exit"
                goodbye
                exit
            when "menu"
                menu
            else
                puts"Unrecognized pokemon, please try again."
            end
        end
    end
    def search_by_type
        input = nil
        while input != "exit"
            input = gets.strip.downcase
            case input
            when "fire"
                puts "all fire type pokemon"
            when "exit"
                goodbye
                exit
            when "menu"
                menu
            else
                puts "Unrecognized type, please try again."
            end
        end
    end
    def search_by_region
        input = nil
        while input != "exit"
            input = gets.strip.downcase
            case input
            when "kanto"
                puts "all kanto pokemon"
            when "exit"
                goodbye
                exit
            when "menu"
                menu
            else 
                puts "unrecognized region, please try again."
            end
        end
    end
end