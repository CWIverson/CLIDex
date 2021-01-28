require_relative 'get_requester.rb'
class Region
    @@all=[]
    def initialize(name)
        @name=name
        @@all<<self
        @pokedex_url
        @pokemon = []
    end
    def get_pokedex_url
        region = GetRequester.new("https://pokeapi.co/api/v2/region/#{@name}")
        region_check=region.input_checker
        if region_check.is_a? String
            return region_check
        end
        @pokedex_url = region_check["pokedexes"][0]["url"]
    end 
    def get_pokedex
        self.get_pokedex_url
        pokedex  = GetRequester.new("#{@pokedex_url}").json_parser
        @pokemon = pokedex["pokemon_entries"].map do |pokemon|
            p = Pokemon.find_or_create(pokemon["pokemon_species"]["name"]) 
            p
         end
    end
end
