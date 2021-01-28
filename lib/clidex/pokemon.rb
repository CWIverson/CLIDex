require_relative 'get_requester.rb'
class Pokemon
    @@all=[]
    attr_accessor :name, :type, :url, :flavor_text, :abilities, :valid
    def  initialize(name)
        @name = name
        @@all<<self
        @valid = "valid"
    end
    def self.all
        @@all
    end
    def self.find(name)
        self.all.find do |p|
            p.name == name.downcase
        end
    end
    def self.find_or_create(name)
        self.find(name) || self.new(name)
    end
    def find_flavor_text
        info = GetRequester.new("https://pokeapi.co/api/v2/pokemon-species/#{name}").input_checker
        if info == "invalid input"
            @valid = "invalid"
        else
            text_hash = self.flavor_text = info["flavor_text_entries"].find do |entry|
                entry["language"]["name"] == "en"
            end
            self.flavor_text = text_hash["flavor_text"].split(' ').join(' ')
        end
    end
    def find_ability        
        ability_json = GetRequester.new("https://pokeapi.co/api/v2/pokemon/#{name}").input_checker
        if ability_json == "invalid input"
            @valid = "invalid"
        else
            self.abilities = ability_json["abilities"][0]["ability"]["name"].split(" ").join(" ")
        end
    end
end