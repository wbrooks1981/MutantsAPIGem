module MutantsAPIGem
  class Enrollment
    attr_accessor :id, :student, :term
    attr_reader :create_date, :modified_date

    def initialize(mutant, term)
      @id      = nil
      @student = mutant
      @term = term
    end

    def create_for_term
      MutantsAPIGem::Routes::Enrollments.create_for_term(@term, @student)
      return response unless response.code == 201
      @id = response["id"]
      @create_date = response["created_at"]
      @modified_date = response["updated_at"]
    end

    def create_for_mutant
      response = MutantsAPIGem::Routes::Enrollments.create_for_mutant(@student, @term)
      return response unless response.code == 201
      @id = response["id"]
      @create_date = response["created_at"]
      @modified_date = response["updated_at"]
    end

    def delete_for_term
      response = MutantsAPIGem::Routes::Enrollments.delete_for_term(@term, self)
      @id = nil if response.code == 204
    end

    def delete_for_mutant
      response = MutantsAPIGem::Routes::Enrollments.delete_for_mutant(@student, self)
      @id = nil if response.code == 204
    end

    def retrieve_for_mutant
      MutantsAPIGem::Routes::Enrollments.retrieve_for_mutant(@student, self)
    end

    def retrieve_for_term
      MutantsAPIGem::Routes::Enrollments.retrieve_for_term(@term, self)
    end

    def to_h
      { :id => @id,
        :student => @student.to_h,
        :term => @term.to_h,
        :created_at => @create_date,
        :updated_at => @modified_date}
    end
  end
end