require_relative 'get_requester.rb'
class Pokemon
    @@all=[]
    attr_accessor :name, :type, :url, :flavor_text, :abilities, :valid
    def  initialize(name)
        @name = name
        # @flavor_text = self.find_flavor_text
        # @abilities = self.find_ability
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

    # def self.search_by_name(name)
    #     pokemon = self.find(name)
    #     if !pokemon
    #         info = GetRequester.new("https://pokeapi.co/api/v2/pokemon-species/#{name}")
    #         checked= info.input_checker
    #             if checked.is_a? String
    #                 return checked
    #             end
    #         english = []
    #         if checked != nil
    #             checked["flavor_text_entries"].map do |entry|
    #                 language = entry["language"]["name"]
    #                 if language == "en"
    #                     english<<entry
    #                 end
    #             end
    #         end
    #         pokemon = self.new(name)
    #         pokemon.flavor_text = english[0]["flavor_text"].split(" ").join(" ")
    #         description = checked["flavor_text_entries"][0]["flavor_text"].split(" ").join(" ")
    #         abilities = GetRequester.new("https://pokeapi.co/api/v2/pokemon/#{name}").json_parser
    #         pokemon.abilities = abilities["abilities"][0]["ability"]["name"].split(" ").join(" ")
    #     elsif !pokemon.abilities
    #         info = GetRequester.new("https://pokeapi.co/api/v2/pokemon-species/#{name}")
    #         checked = info.input_checker
    #         pokemon.flavor_text = checked["flavor_text_entries"].find do |entry|
    #             entry["language"]["name"] == "en"
    #         end["flavor_text"].split(" ").join(" ")
    #         abilities = GetRequester.new("https://pokeapi.co/api/v2/pokemon/#{name}").json_parser
    #         pokemon.abilities = abilities["abilities"][0]["ability"]["name"].split(" ").join(" ")
    #     end
    #     puts "#{pokemon.flavor_text} Ability: #{pokemon.abilities}"
    # end 
    # def create
    #     Pokemon.new(name)
    # end
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

# bulbasaur = Pokemon.new('bulbasaur')
# puts bulbasaur.abilities