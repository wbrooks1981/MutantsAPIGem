require "MutantsAPIGem/version"
require_relative "../lib/Routes/mutants"
require_relative "../lib/Support/mutant"
require_relative "../lib/Support/term"
require_relative "../lib/Routes/terms"
require_relative "../lib/Support/enrollment"

module MutantsAPIGem
  class << self
    def mutants
      @mutants ||= []
    end

    def terms
      @terms ||= []
    end

    def clean_up
      while mutants.count > 0
        mutants.last.delete
      end
      while terms.count > 0
        terms.last.delete
      end
    end
  end
end
