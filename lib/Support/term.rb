module MutantsAPIGem
  class Term
    attr_accessor :id, :begin_date, :end_date

    def initialize(options = {})
      @id = nil
      @begin_date = options[:begin_date]
      @end_date = options[:end_date]
    end

    def create

    end

    def retrieve

    end

    def update

    end

    def delete

    end

    def to_json
      to_h.to_json
    end

    def to_h
      { :begin_date => @begin_date,
        :ends_at => @end_date }
    end
  end
end
