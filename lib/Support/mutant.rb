module MutantsAPIGem
  class Mutant
    attr_accessor :alias, :name, :ability, :eligibility_begin_date, :eligibility_end_date, :advise_begin_date
    attr_reader :id, :created_date, :modified_date, :enrolls

    def initialize(options = {})
      @id      = nil
      @enrolls = []
      @name    = options[:name]
      @alias   = options[:alias]
      @ability = options[:ability]
      @eligibility_begin_date = options[:eligibility_begin_date]
      @eligibility_end_date = options[:eligibility_end_date]
      @advise_begin_date = options[:advise_begin_date]
    end

    def create
      puts "Creating Mutant: #{@alias}"
      response = MutantsAPIGem::Routes::Mutants.create(self)
      return response unless response.code == 201
      @id = response["id"] unless response.nil?
      @created_date = response["created_at"]
      @modified_date = response["updated_at"]
      MutantsAPIGem.mutants.push(self)
      puts "Created Mutant: #{@alias}"
    end

    def retrieve
      puts "Retrieving Mutant: #{@alias}"
      response = MutantsAPIGem::Routes::Mutants.retrieve(self)
      return response unless response.code == 200
      puts "Retrieved Mutant: #{@alias}"
      response
    end

    def update
      puts "Updating Mutant: #{@id}"
      response = MutantsAPIGem::Routes::Mutants.update(self)
      return response unless response.code == 200
      @modified_date = response["updated_at"]
      puts "Updated Mutant: #{@id}"
    end

    def delete
      puts "Deleting Mutant: #{@alias}"
      response = MutantsAPIGem::Routes::Mutants.delete(self)
      return response unless response.code == 204
      @id = nil
      MutantsAPIGem.mutants.delete_if { |item| item.id == @id }
      puts "Deleted Mutant: #{@alias}"
    end

    def enroll(term)
      puts "Enrolling Mutant: #{@alias} in term starting #{term.start_date}"
      enrollment = MutantsAPIGem::Enrollment.new(self, term)
      response = MutantsAPIGem::Routes::Mutants.enroll(enrollment)
      return response unless response.code == 201
      enrollment.update_from_response(response)
      @enrolls.push(enrollment)
      puts "Enrolled Mutant: #{@alias} in term starting #{term.start_date}"
      response
    end

    def withdraw(enrollment)
      puts "Withdrawing Mutant: #{@alias} in term starting #{term.start_date}"
      response = MutantsAPIGem::Routes::Mutants.withdraw(enrollment)
      return response unless response.code == 204
      enrollment = nil
      puts "Withdrew Mutant: #{@alias} in term starting #{term.start_date}"
      enrollment
    end

    def enrollments(enrollment = nil)
      puts "Retrieving Mutant Enrollment: #{@alias} enrolled in #{enrollment.id}" unless enrollment.nil?
      response = MutantsAPIGem::Routes::Mutants.enrollments(self, enrollment)
      return response unless response.code == 200
      puts "Retrieved Mutant Enrollment: #{@alias} enrolled in #{enrollment.id}" unless enrollment.nil?
      response
    end

    def advise(student)
      puts "Creating Advisor: #{@alias} as an advisor to #{student.alias}"
      response = MutantsAPIGem::Routes::Mutants.advise(self, student)
      return response unless response.code == 201
      puts "Created Advisor: #{@alias} as an advisor to #{student.alias}"
      response
    end

    def advisees
      puts "Retrieving Students: All students of advisor #{@alias}"
      response = MutantsAPIGem::Routes::Mutants.advisees(self)
      return response unless response.code == 200
      puts "Retrieved Students: All students of advisor #{@alias}"
      response
    end

    def remove_advisee(student)
      puts "Removing Advisor: #{@alias} as an advisor to #{student.alias}"
      response = MutantsAPIGem::Routes::Mutants.remove_advisee(self, student)
      return response unless response.code == 200
      puts "Removed Advisor: #{@alias} as an advisor to #{student.alias}"
      response
    end

    def to_h
      { :id                      => @id,
        :real_name               => @name,
        :mutant_name             => @alias,
        :power                   => @ability,
        :eligibility_begins_at   => @eligibility_begin_date,
        :eligibility_ends_at     => @eligibility_end_date,
        :may_advise_beginning_at => @advise_begin_date
      }
    end

    def to_advisor(student)
      { :advisee => { :id => student.id }}
    end
  end
end