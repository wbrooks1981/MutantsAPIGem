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
          puts "Retrieving Terms" if term.nil?
          @payload = nil
          @route = "#{end_point}"
          @route += term.id.to_s unless term.nil?
          @response = HTTParty.get(@route)
          puts "Retrieved Terms" if term.nil? && @response.code == 200
          @response
        end

        def update(term)
          @payload = term.to_json
          @route = "#{end_point}#{term.id}"
          @response = HTTParty.put(@route,:body => @payload, :headers => {"Content-Type" => "application/json" } )
        end

        def delete(term)
          @payload = nil
          @route = "#{end_point}#{term.id}"
          @response = HTTParty.delete(@route)
        end

        def enroll(enrollment)
          @route    = "#{end_point}#{enrollment.term.id}/enrollments"
          @payload = { :enrollment => { :mutant_id => enrollment.mutant.id }}.to_json
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def withdraw(enrollment)
          @route    = "#{end_point}#{enrollment.term.id}/enrollments/#{enrollment.id}"
          @response = HTTParty.delete(@route)
        end

        def enrollments(term, enrollment = nil)
          puts "Retrieving Enrollments" if enrollment.nil?
          @route    = "#{end_point}#{term.id}/enrollments/"
          @route += enrollment.id.to_s unless enrollment.nil?
          @response = HTTParty.get(@route)
          puts "Retrieved Enrollments" if enrollment.nil? && @response.code == 200
          @response
        end

        private

        def end_point
          "https://mutant-school.herokuapp.com/api/v1/terms/"
        end
      end
    end
  end
end
