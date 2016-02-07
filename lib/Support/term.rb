module MutantsAPIGem
  class Term
    attr_accessor :start_date, :end_date
    attr_reader :id, :created_date, :modified_date, :enrolls

    def initialize(options = {})
      @id = nil
      @created_date = nil
      @modified_date = nil
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
      puts "Term removing Mutant: Term staring #{@start_date} removes #{mutant.alias}"
      response = MutantsAPIGem::Routes::Terms.withdraw(enrollment)
      return response unless response.code == 204
      @enrolls.delete(enrollment)
      puts "Term Added Mutant: Term staring #{@start_date} adds #{mutant.alias}"
      response
    end

    def enrollments(enrollment = nil)
      puts "Retrieving Term Enrollment: Enrollment #{enrollment.id} in term #{@id}" unless enrollment.nil?
      response = MutantsAPIGem::Routes::Terms.enrollments(self, enrollment)
      return response unless response.code == 200
      puts "Retrieved Term Enrollment: Enrollment #{enrollment.id} in term #{@id}" unless enrollment.nil?
      response
    end

    def to_h
      { :begins_at => @start_date,
        :ends_at => @end_date }
    end
  end
end
