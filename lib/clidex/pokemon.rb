
require_relative 'get_requester.rb'
class Pokemon
    @@all=[]
    attr_accessor :name, :type
    def  initialize(name)
        @name = name
        @@all<<self
    end
    def self.search_by_name(name)
        info = GetRequester.new("https://pokeapi.co/api/v2/pokemon-species/#{name}")
        checked= info.input_checker
        if checked.is_a? String
            return checked
        end
        english = []
        checked["flavor_text_entries"].map do |entry|
            language = entry["language"]["name"]
            if language == "en"
                english<<entry
            end
        end
        text = english[0]["flavor_text"].split(" ").join(" ")
        description = checked["flavor_text_entries"][0]["flavor_text"].split(" ").join(" ")
        abilities = GetRequester.new("https://pokeapi.co/api/v2/pokemon/#{name}").json_parser
        ability_rundown = abilities["abilities"][0]["ability"]["name"].split(" ").join(" ")
        puts desc_and_ability = "#{text} Ability: #{ability_rundown}"  
    end    
end

#puts Pokemon.search_by_name("bulbasaur")