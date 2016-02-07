require_relative "../test_helper"

describe MutantsAPIGem::Term do
  before do
    term = {:start_date => Date.today + 5,:end_date => Date.today + 90}
    @term = MutantsAPIGem::Term.new(term)
  end

  it 'should have the expected payload' do
    payload = @term.to_h
    payload[:begins_at].must_equal Date.today + 5
    payload[:ends_at].must_equal Date.today + 90
  end
end