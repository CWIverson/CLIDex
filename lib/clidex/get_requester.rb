require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetRequester
    @@search_history=[]
    attr_reader :category, :searched_item, :url
    def initialize(search_category, search_term)
        @category=search_category
        @searched_item = search_term
        @url= "https://pokeapi.co/api/v2/#{search_category}/#{search_term}"

    end
    def get_response_body
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body
        #binding.pry
    end
    def json_parser
        input = self.get_response_body
        JSON.parse(input)
    end

end

object = GetRequester.new("pokemon-species", "charmander")

puts object.json_parser