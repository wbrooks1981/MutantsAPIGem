require "httparty"
module MutantsAPIGem
  module Routes
    module Terms
      class << self
        attr_accessor :payload, :route, :response
        def create(term)
          @payload = term.to_json
          @route = "https://mutant-school.herokuapp.com/api/v1/terms"
          @response = HTTParty.post(@route,:body => @payload, :headers => {"Content-Type" => "application/json" } )
        end

        def delete(term)
          @payload = nil
          @route = "https://mutant-school.herokuapp.com/api/v1/terms/#{term.id}"
          @response = HTTParty.delete(@route)
        end

        def retrieve(term = nil)
          @payload = nil
          @route = "https://mutant-school.herokuapp.com/api/v1/terms/"
          @route += term.id unless term.nil?
          @response = HTTParty.get(@route)
        end
      end
    end
  end
end
