require_relative 'get_requester.rb'
class Type
    @@all=[]

    def initialize(name)
        @name= name
        @@all<<self
        @pokemon = []
    end

    def search_by_type
        type_list = GetRequester.new("https://pokeapi.co/api/v2/type/#{@name}")
        checked = type_list.input_checker
        if checked.is_a? String
            return checked
        end
        @pokemon = checked["pokemon"].map do |pokemon|
        p = Pokemon.find_or_create(pokemon["pokemon"]["name"])
       
        end
    end

   
    
end
#puts Type.new("water").search_by_type("water")