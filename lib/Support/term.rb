module MutantsAPIGem
  class Term
    attr_accessor :id, :start_date, :end_date
    attr_reader :create_date, :modified_date, :enrolls

    def initialize(options = {})
      @id = nil
      @enrolls = []
      @start_date = options[:start_date]
      @end_date = options[:end_date]
    end

    def create
      puts "Creating Term: Starting #{@start_date}"
      response = MutantsAPIGem::Routes::Terms.create(self)
      return response unless response.code == 201
      @id = response["id"]
      @created_date = response["created_at"]
      @modified_date = response["updated_at"]
      MutantsAPIGem.terms.push(self)
      puts "Created Term: Starting #{@start_date}"
    end

    def retrieve
      puts "Retrieving Term: Starting #{@start_date}"
      response = MutantsAPIGem::Routes::Terms.retrieve(self)
      return response unless response.code == 200
      puts "Retrieved Mutant: Starting #{@start_date}"
      response
    end

    def update
      puts "Updating Term: #{@id}"
      response = MutantsAPIGem::Routes::Terms.update(self)
      return response unless response.code == 200
      @modified_date = response["updated_at"]
      puts "Term Updated: #{@id}"
    end

    def delete
      puts "Deleting Term: Starting #{@start_date}"
      response = MutantsAPIGem::Routes::Terms.delete(self)
      return response unless response.code == 204
      MutantsAPIGem.terms.delete(self)
      @id = nil
      puts "Deleted Term: Starting #{@start_date}"
    end

    def enroll(mutant)
      puts "Term adding Mutant: Term staring #{@start_date} adds #{mutant.alias}"
      enrollment = MutantsAPIGem::Enrollment.new(mutant, self)
      response = MutantsAPIGem::Routes::Terms.enroll(enrollment)
      return response unless response.code == 201
      enrollment.update_from_response(response)
      @enrolls.push(enrollment)
      puts "Term Added Mutant: Term staring #{@start_date} adds #{mutant.alias}"
      response
    end

    def withdraw(enrollment)
      MutantsAPIGem::Routes::Terms.withdraw(enrollment)
    end

    def enrollments(enrollment = nil)
      MutantsAPIGem::Routes::Terms.enrollments(self, enrollment)
    end

    def to_json
      to_h.to_json
    end

    def to_h
      { :begins_at => @start_date,
        :ends_at => @end_date }
    end
  end
end
