module MutantsAPIGem
  class Enrollment
    attr_accessor :mutant, :term
    attr_reader :id, :create_date, :modified_date

    def initialize(mutant, term)
      @id      = nil
      @mutant = mutant
      @term = term
    end

    def update_from_response(response)
      @id = response["id"]
      @create_date = response["created_at"]
      @modified_date = response["updated_at"]
    end

    def to_term
      { :enrollment => { :term_id => @term.id }}
    end

    def to_mutant
      { :enrollment => { :mutant_id => @mutant.id }}
    end
  end
end