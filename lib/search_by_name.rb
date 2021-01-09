require 'net/http'
require 'open-uri'
require 'json'


class SearchByName
    attr_reader :pokemon, :category
    def initialize(category, pokemon)
        @pokemon = pokemon
        @category = category
        @get_requests = []
    end
    def get_requester
        search_results = GetRequester.new(@category, @pokemon)
        @get_requests<<search_results
        result_body = search_results.json_parser
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
puts test_run.get_requester
#flavor_text = test_run.get_flavor_text
#puts flavor_text
