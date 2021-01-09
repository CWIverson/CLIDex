require 'net/http'
require 'open-uri'
require 'json'
require 'pry'

class GetRequester
    
    attr_reader :category, :searched_item, :url
    def initialize(url)
        @url= url

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

