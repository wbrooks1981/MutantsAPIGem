require_relative "../test_helper"

describe MutantsAPIGem::Mutant do
  before do
    mutant = { :name => "Victor",
               :alias => "Colossus",
               :ability => "Metal Man",
               :eligibility_begin_date => Date.today + 5,
               :eligibility_end_date => Date.today + 10,
               :advise_begin_date => Date.today + 30 }
    @mutant = MutantsAPIGem::Mutant.new(mutant)
    @created_response = %w("id": 2,
                        "mutant_name": "Superdave",
                        "power": "Flight",
                        "real_name": "Dave",
                        "created_at": "2016-02-02T21:24:45.964Z",
                        "updated_at": "2016-02-02T21:24:45.964Z",
                        "eligibility_begins_at": "2010-01-01T00:00:00.000Z",
                        "eligibility_ends_at": "2020-01-01T00:00:00.000Z",
                        "may_advise_beginning_at": "2016-01-01T00:00:00.000Z",
                        "url": "https://mutant-school.herokuapp.com/api/v1/mutants/2")
  end

  it 'should have the expected payload' do
    payload = @mutant.to_h
    payload[:power].must_match "Metal Man"
    payload[:real_name].must_match "Victor"
    payload[:mutant_name].must_match "Colossus"
    payload[:eligibility_begins_at].must_equal Date.today + 5
    payload[:eligibility_ends_at].must_equal Date.today + 10
    payload[:may_advise_beginning_at].must_equal Date.today + 30
  end

  # it 'should create a mutant' do
  #   @mutant.create
  # end

end