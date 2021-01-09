require 'pry'
require_relative 'get_requester.rb'
class Pokemon
    attr_accessor :name, :type
    def  initialize(name)
        @name = name
        @type = []
        
    end
    def search_by_name(name)
        info = GetRequester.new("https://pokeapi.co/api/v2/pokemon-species/#{name}").json_parser
        stats = GetRequester.new("https://pokeapi.co/api/v2/pokemon/#{name}").json_parser
        #binding.pry
    end

end
test = Pokemon.new("charmander")
test.search_by_name("charmander")