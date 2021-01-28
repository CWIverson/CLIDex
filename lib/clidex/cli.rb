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
    def find_pokemon_entry(input)
        pokemon = Pokemon.find_or_create(input)
        pokemon.find_ability
        pokemon.find_flavor_text
        if pokemon.valid == "valid"
            puts "#{pokemon.flavor_text} Ability: #{pokemon.abilities}"
        else
            puts "Invalid input. Please try again."
        end
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
                pokemon = find_pokemon_entry(input)
            end
        end
        goodbye
    end
    def new_type_search(input)
        type = Type.new(input)
        type.search_by_type
    end
    def search_pokemon(input, search_type)
        if search_type == 'region'
            pokemon = new_region_search(input)
        elsif search_type == 'type'
            pokemon = new_type_search(input)
        end

        if pokemon == "invalid input"
            puts "Invalid input, try again."
            search_by_type
        else
            pokemon.map do |pokemon|
                pokemon
            end
        end
    end
    

    def pokemon_list_search(new_input, input, search_type)
        list = search_pokemon(input, search_type)
        found_pokemon = list.find do |pokemon|
            pokemon.name == new_input
        end
        find_pokemon_entry(new_input)
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
                list_print(input, 'type')
                list = search_pokemon(input, "type")
                
                new_input = nil
                while new_input != "exit"
                    puts "type the name of a pokemon you want to know more about"
                    new_input = gets.strip.downcase
                    if new_input == "exit"
                        goodbye
                    elsif new_input == "menu"
                        menu
                    else
                        pokemon_list_search(new_input, input, 'type')
                        
                    end
                end
            end
        end
    end
    def new_region_search(input)
        region = Region.new(input)
        region.get_pokedex
    end
    def list_print(input, search_type)
        list = search_pokemon(input, search_type)
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
               list_print(input, 'region')
               list = search_pokemon(input, "type")
                new_input = nil
                while new_input != "exit"
                    puts "type the name of a pokemon you want to know more about"
                    new_input = gets.strip.downcase
                    if new_input == "exit"
                        goodbye
                    elsif new_input == "menu"
                        menu
                    else
                        pokemon_list_search(new_input, input, 'region')       
                    end
                end
            end
        end
    end
end