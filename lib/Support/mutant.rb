module MutantsAPIGem
  class Mutant
    attr_accessor :id, :alias, :name, :ability, :eligibility_begin_date, :eligibility_end_date, :advise_begin_date
    attr_reader :create_date, :modified_date

    def initialize(options = {})
      @id      = nil
      @name    = options[:name]
      @alias   = options[:alias]
      @ability = options[:ability]
      @eligibility_begin_date = options[:eligibility_begin_date]
      @eligibility_end_date = options[:eligibility_end_date]
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
      response = MutantsAPIGem::Routes::Mutants.enroll(enrollment)
      return enrollment unless response.code == 201
      enrollment.update_from_response(response)
      enrollment
    end

    def withdraw(enrollment)
      MutantsAPIGem::Routes::Mutants.withdraw(enrollment)

    end

    def enrollments(enrollment = nil)
      MutantsAPIGem::Routes::Mutants.enrollments(self, enrollment)
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