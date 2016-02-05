module MutantsAPIGem
  class Mutant
    attr_accessor :id, :alias, :name, :ability, :eligibility_begin_date, :eligibility_end_date, :advise_begin_date
    attr_reader :create_date, :modified_date, :enrollments

    def initialize(options = {})
      @id      = nil
      @enrollments = []
      @name    = options[:name]
      @alias   = options[:alias]
      @ability = options[:ability]
    end

    def create
      response = MutantsAPIGem::Routes::Mutants.create(self)
      return response unless response.code == 201
      @id = response["id"] unless response.nil?
      @create_date = response["created_at"]
      @modified_date = response["updated_at"]
    end

    def retrieve
      MutantsAPIGem::Routes::Mutants.retrieve(self)
    end

    def update
      response = MutantsAPIGem::Routes::Mutants.update(self)
      @modified_date = response["updated_at"]
    end

    def delete
      response = MutantsAPIGem::Routes::Mutants.delete(self)
      @id = nil if response.code == 204
    end

    def enroll(term)
      enrollment = MutantsAPIGem::Enrollment.new(self, term)
      enrollment.create
    end

    def enrollment_withdraw(enrollment)
      MutantsAPIGem::Routes::Enrollments.delete_for_mutant(self, enrollment)

    end

    def retrieve_enrollments(enrollment = nil)
      MutantsAPIGem::Routes::Enrollments.retrieve(self, enrollment)
    end

    def to_json
      to_h.to_json
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
  end
end