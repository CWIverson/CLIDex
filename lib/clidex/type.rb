require_relative 'get_requester.rb'
class Type
    @@all=[]

    def initialize(name)
        @name= name
        @@all<<self
    end

    def self.search_by_type(type_name)
        type_list = GetRequester.new("https://pokeapi.co/api/v2/type/#{type_name}")
        checked = type_list.input_checker
        if checked.is_a? String
            return checked
        end
        type_pokemon = checked["pokemon"].map do |pokemon|
            pokemon["pokemon"]["name"]
        end
        puts type_pokemon
    end
    
end
#puts Type.new("water").search_by_type("water")