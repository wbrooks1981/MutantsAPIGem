module MutantsAPIGem
  class Term
    attr_accessor :id, :start_date, :end_date
    attr_reader :create_date, :modified_date, :enrollments

    def initialize(options = {})
      @id = nil
      @enrollments = []
      @start_date = options[:begin_date]
      @end_date = options[:end_date]
    end

    def create
      response = MutantsAPIGem::Routes::Terms.create(self)
      return response unless response.code == 201
      @id = response["id"]
      @create_date = response["created_at"]
      @modified_date = response["updated_at"]
    end

    def retrieve
      MutantsAPIGem::Routes::Terms.retrieve(self)
    end

    def update
      response = MutantsAPIGem::Routes::Terms.update(self)
      @modified_date = response["updated_at"]
    end

    def delete
      response = MutantsAPIGem::Routes::Terms.delete(self)
      @id = nil if response.code == 204
    end

    def enroll(term)
      enrollment = MutantsAPIGem::Enrollment.new(self, term)
      enrollment.create
    end

    def enrollment_withdraw(enrollment)
      MutantsAPIGem::Routes::Enrollments.delete_for_term(self, enrollment)
    end

    def retrieve_enrollments(enrollment = nil)
      MutantsAPIGem::Routes::Enrollments.retrieve(self, enrollment)
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
