require 'net/http'
require 'open-uri'
require 'json'


class SearchByName
    attr_reader :pokemon, :category
    def initialize(category, pokemon)
        @pokemon = pokemon
        @category = category
    end
    def get_requester
        GetRequester.new(@category, @pokemon)
    end
    def get_flavor_text
        flavor_text = []
        self.find_searched_pokemon.map do |main_category, array|
            
            if main_category == "flavor_text_entries"
                flavor_text = array[0]
            end
        end
    end

end
test_run = SearchByName.new("pokemon", "charmander")
puts test_run
#flavor_text = test_run.get_flavor_text
#puts flavor_text
