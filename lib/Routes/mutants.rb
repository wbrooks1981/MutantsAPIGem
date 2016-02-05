require "httparty"
module MutantsAPIGem
  module Routes
    module Mutants
      class << self
        attr_accessor :payload, :route, :response

        def create(mutant)
          @payload  = mutant.to_json
          @route    = "https://mutant-school.herokuapp.com/api/v1/mutants"
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def retrieve(mutant = nil)
          @payload  = nil
          @route    = "https://mutant-school.herokuapp.com/api/v1/mutants/"
          @route    += mutant.id.to_s unless mutant.nil?
          @response = HTTParty.get(@route)
        end

        def update(mutant)
          @payload = mutant.to_json
          @route   = "https://mutant-school.herokuapp.com/api/v1/mutants/#{mutant.id}"
          @response = HTTParty.put(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def delete(mutant)
          @payload  = nil
          @route    = "https://mutant-school.herokuapp.com/api/v1/mutants/#{mutant.id}"
          @response = HTTParty.delete(@route)
        end
      end
    end
  end
end
