require_relative 'pokemon.rb'
require_relative 'type.rb'
require_relative 'region.rb'
require_relative 'get_requester.rb'
require 'pry'
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
                puts "CLIDex is a command line pokedex. Find information on any pokemon!"
            when "2"
                search_by_name
            when "3"         
                search_by_type
            when "4"
                search_by_region
            when "5"
                puts "At the main menu simply enter the number of the menu item you want to use. 

                If searching for a pokemon by name, just enter that pokemons name into the console.
                
                If searching by type, enter the type of pokemon you are looking for. This will return a list of pokemon of that type. If you see a pokemon you wish to get a closer look at you can enter its name into the console to bring up its details.
                
                If searching by region, enter which region you want to see the pokemon for. This will return a list of pokemon from that region. Enter the name of any of those pokemon to bring up their details."
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
        
        input = nil
        while input != "exit"
            puts "What's the name of the pokemon you would like to search?"
            input = gets.strip.downcase 
            if input == "menu"
                menu
            elsif input == "exit"
                goodbye
            else
                pokemon = Pokemon.find_or_create(input)
                pokemon.find_ability
                pokemon.find_flavor_text
                if pokemon.valid == "valid"
                    puts "#{pokemon.flavor_text} Ability: #{pokemon.abilities}"
                else
                    puts "Invalid input. Please try again."
                end
            end            
        end
        goodbye
    end
    def new_type_search(input)
        type = Type.new(input)
        type.search_by_type
    end
    def search_pokemon(input)
        pokemon = new_type_search(input)
        if pokemon == "invalid input"
            puts "Invalid input, try again."
            search(gets.strip.downcase)
        else
            pokemon.map do |pokemon|
                pokemon
            end
        end
    end
    def type_list_print(input)
        list = search_pokemon(input)
        list.each do |pokemon|
            puts pokemon.name
        end
    end

    def search_by_type
        
        input = nil
        while input != "exit"
            puts "What type of pokemon would you like to search for?"
            input = gets.strip.downcase
            if input == "exit"
                goodbye
            elsif input == "menu"
                menu
            else                
                type_list_print(input)
                list = search_pokemon(input)
                
                new_input = nil
                while new_input != "exit"
                    puts "type the name of a pokemon you want to know more about"
                    new_input = gets.strip.downcase
                    if new_input == "exit"
                        goodbye
                    elsif new_input == "menu"
                        menu
                    else
                        found_pokemon = list.find do |pokemon|
                            pokemon.name == new_input
                        end
                        if found_pokemon == nil
                            puts "invalid input. Please try again."
                        else
                            found_pokemon.find_ability
                            found_pokemon.find_flavor_text     
                            puts "#{found_pokemon.flavor_text} Ability: #{found_pokemon.abilities}"
                        end
                        # binding.pry
                        
                    end
                end
            end
        end
    end
    def new_region_search(input)
        region = Region.new(input)
        region.get_pokedex
    end
    def search_list(input)
        pokemon = new_region_search(input)      
        if pokemon == "invalid input"
            puts "Invalid input, try again."
            search(gets.strip.downcase)
        else
            pokemon.map do |pokemon|
                pokemon
            end
        end
    end
    def list_print(input)
        list = search_list(input)
        list.each do |pokemon|
            puts pokemon.name
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
               list_print(input)
               list = search_list(input)
                # binding.pry
                new_input = nil
                while new_input != "exit"
                    puts "type the name of a pokemon you want to know more about"
                    new_input = gets.strip.downcase
                    if new_input == "exit"
                        goodbye
                    elsif new_input == "menu"
                        menu
                    else
                        found_pokemon = list.find do |pokemon|
                                            pokemon.name == new_input
                                        end
                        found_pokemon.find_ability
                        found_pokemon.find_flavor_text     
                        puts "#{found_pokemon.flavor_text} Ability: #{found_pokemon.abilities}"
                        # binding.pry           
                    end
                end
            end
        end
    end
end