require "httparty"
module MutantsAPIGem
  module Routes
    module Enrollments
      class << self
        attr_accessor :payload, :route, :response

        def create_for_mutant(mutant, term)
          @route    = "#{end_point}#{mutant.id}/enrollments"
          @payload = { :enrollment => { :term_id => term.id }}.to_json
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def retrieve_for_mutant(mutant, enrollment = nil)
          @route    = "#{end_point}#{mutant.id}/enrollments/"
          @route += enrollment.id.to_s unless enrollment.nil?
          @response = HTTParty.get(@route)
        end

        def delete_for_mutant(mutant, enrollment)
          @route    = "#{end_point}#{mutant.id}/enrollments/#{enrollment.id}"
          @response = HTTParty.delete(@route)
        end

        def create_for_term(term, mutant)
          @route    = "#{end_point}#{term.id}/enrollments"
          @payload = { :enrollment => { :mutant_id => mutant.id }}.to_json
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def retrieve_for_term(term, enrollment = nil)
          @route    = "#{end_point}#{term.id}/enrollments/"
          @route += enrollment.id.to_s unless enrollment.nil?
          @response = HTTParty.get(@route)
        end

        def delete_for_term(term, enrollment)
          @route    = "#{end_point}#{term.id}/enrollments/#{enrollment.id}"
          @response = HTTParty.delete(@route)
        end

        def end_point
          "https://mutant-school.herokuapp.com/api/v1/mutants/"
        end
      end
    end
  end
end