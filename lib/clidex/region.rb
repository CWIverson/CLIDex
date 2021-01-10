require_relative 'get_requester.rb'
class Region
    @@all=[]

    def initialize(name)
        @name=name
        @@all<<self
    end

    def self.search_by_region(name)
        region  = GetRequester.new("https://pokeapi.co/api/v2/pokedex/#{name}")
        checked = region.input_checker
        if checked.is_a? String
            return checked
        end
        pokemon_list = checked["pokemon_entries"].map do |pokemon|
            pokemon["pokemon_species"]["name"]
        end
    end
   
end
puts Region.new("kanto").search_by_region("kanto")