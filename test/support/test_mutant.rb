require_relative "../test_helper"

describe MutantsAPIGem::Mutant do
  before do
    mutant = { :name => "Victor", :alias => "Colossus", :ability => "Metal Man"}
    @mutant = MutantsAPIGem::Mutant.new(mutant)
  end

  it 'should have correct ability for payload' do
    @mutant.to_h[:power].must_match "Metal Man"
  end

  it 'should have correct name for payload' do
    @mutant.to_h[:real_name].must_match "Victor"
  end

  it 'should have correct name for payload' do
    @mutant.to_h[:mutant_name].must_match "Colossus"
  end
end