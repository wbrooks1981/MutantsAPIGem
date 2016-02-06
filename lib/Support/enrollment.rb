module MutantsAPIGem
  class Enrollment
    attr_accessor :id, :mutant, :term
    attr_reader :create_date, :modified_date

    def initialize(mutant, term)
      @id      = nil
      @mutant = mutant
      @term = term
    end

    def to_h
      { :id => @id,
        :student => @mutant.to_h,
        :term => @term.to_h,
        :created_at => @create_date,
        :updated_at => @modified_date}
    end

    def update_from_response(response)
      @id = response["id"]
      @create_date = response["created_at"]
      @modified_date = response["updated_at"]
    end
  end
end