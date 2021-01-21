require_relative 'get_requester.rb'
#require 'pry'
class Region
    @@all=[]

    def initialize(name)
        @name=name
        @@all<<self
        @pokedex_url
    end
    def self.get_pokedex(name)
        region = GetRequester.new("https://pokeapi.co/api/v2/region/#{name}")
        region_check=region.input_checker
        if region_check.is_a? String
            return region_check
        end
        #binding.pry
        @pokedex_url = region_check["pokedexes"][0]["url"]
    end 
    def self.search_by_region(name)
        check = self.get_pokedex(name)
        if check == "invalid input"
            return nil
        end
        pokedex  = GetRequester.new("#{@pokedex_url}")
        checked = pokedex.input_checker
        
        pokemon_list = checked["pokemon_entries"].map do |pokemon|
           p = Pokemon.find_or_create(pokemon["pokemon_species"]["name"])
          # p.url = pokemon["pokemon_species"]["url"]
           p
        end
       
    end
   
end
#Region.get_pokedex("kanto")