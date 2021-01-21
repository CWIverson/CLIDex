require 'net/http'
require 'open-uri'
require 'json'


class GetRequester
    
    attr_reader :category, :searched_item, :url
    def initialize(url)
        @url= url

    end
    def get_response_body
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body
    end
    def input_checker
        if self.get_response_body == "Not Found"  
            
            "invalid input"
        else
            self.json_parser
        end
    end
    def json_parser
        input = self.get_response_body
        JSON.parse(input)
    end

end

