require_relative "../test_helper"

describe MutantsAPIGem::Term do
  before do
    term = {:start_date => Date.today + 5,:end_date => Date.today + 90}
    @term = MutantsAPIGem::Term.new(term)
  end

  it 'should have correct start for payload' do
    @term.to_h[:begins_at].must_equal Date.today + 5
  end

  it 'should have correct end for payload' do
    @term.to_h[:ends_at].must_equal Date.today + 90
  end
end