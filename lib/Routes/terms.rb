require "httparty"
module MutantsAPIGem
  module Routes
    module Terms
      class << self
        attr_accessor :payload, :route, :response
        def create(term)
          @payload = term.to_json
          @route = "#{end_point}"
          @response = HTTParty.post(@route,:body => @payload, :headers => {"Content-Type" => "application/json" } )
        end

        def retrieve(term = nil)
          @payload = nil
          @route = "#{end_point}"
          @route += term.id unless term.nil?
          @response = HTTParty.get(@route)
        end

        def update(term)
          @payload = term.to_json
          @route = "#{end_point}#{term.id}"
          @response = HTTParty.put(@route)
        end

        def delete(term)
          @payload = nil
          @route = "#{end_point}#{term.id}"
          @response = HTTParty.delete(@route)
        end

        private

        def end_point
          "https://mutant-school.herokuapp.com/api/v1/terms/"
        end
      end
    end
  end
end
