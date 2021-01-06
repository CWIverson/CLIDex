require 'net/http'
require 'open-uri'
require 'json'


class SearchByName
    @@search_history = []
    def initialize(pokemon)
        @name = pokemon
        @desired_pokemon = pokemon
        @@search_history<<self
    end

    def get_all_pokemon
        

        
    end

    def find_searched_pokemon(pokemon)
        
       
    end
end


