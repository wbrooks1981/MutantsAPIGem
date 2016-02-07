require "httparty"
module MutantsAPIGem
  module Routes
    module Mutants
      class << self
        attr_accessor :payload, :route, :response

        def create(mutant)
          @payload  = mutant.to_json
          @route    = "#{end_point}"
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def retrieve(mutant = nil)
          puts "Retrieving Mutants" if mutant.nil?
          @route    = "#{end_point}"
          @route    += mutant.id.to_s unless mutant.nil?
          @response = HTTParty.get(@route)
          puts "Retrieved Mutants" if mutant.nil? && @response.code == 200
          @response
        end

        def update(mutant)
          @payload = mutant.to_json
          @route   = "#{end_point}#{mutant.id}"
          @response = HTTParty.put(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def delete(mutant)
          @route    = "#{end_point}#{mutant.id}"
          @response = HTTParty.delete(@route)
        end

        def enroll(enrollment)
          @route    = "#{end_point}#{enrollment.mutant.id}/enrollments"
          @payload = { :enrollment => { :term_id => enrollment.term.id }}.to_json
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def withdraw(enrollment)
          @route    = "#{end_point}#{enrollment.mutant.id}/enrollments/#{enrollment.id}"
          @response = HTTParty.delete(@route)
        end

        def enrollments(mutant, enrollment = nil)
          puts "Retrieving Enrollments" if enrollment.nil?
          @route    = "#{end_point}#{mutant.id}/enrollments/"
          @route += enrollment.id.to_s unless enrollment.nil?
          @response = HTTParty.get(@route)
          puts "Retrieved Enrollments" if enrollment.nil? && @response.code == 200
          @response
        end

        def advise(advisor, student)
          @route    = "#{end_point}#{advisor.id}/advisees"
          @payload = { :advisee => { :id => student.id }}.to_json
          @response = HTTParty.post(@route, :body => @payload, :headers => { "Content-Type" => "application/json" })
        end

        def remove_advisee(advisor, student)
          @route    = "#{end_point}#{advisor.id}/advisees/#{student.id}"
          @response = HTTParty.delete(@route)
        end

        def advisees(advisor)
          @route    = "#{end_point}#{advisor.id}/advisees/"
          @response = HTTParty.get(@route)
        end

        def end_point
          "https://mutant-school.herokuapp.com/api/v1/mutants/"
        end
      end
    end
  end
end
