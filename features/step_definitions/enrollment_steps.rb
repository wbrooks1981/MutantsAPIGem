require "MutantsAPIGem"

When(/^A mutant enrolls in a term$/) do
  @enrollment = MutantsAPIGem::Enrollment.new(@mutant, @term)
  @enrollment.create_for_mutant
end

Then(/^the term will have the mutant$/) do
  raise "Mutant didn't get enrolled into term" if @enrollment.id.nil?
end

When(/^A mutant is added to a term$/) do
  @enrollment = MutantsAPIGem::Enrollment.new(@mutant, @term)
  @enrollment.create_for_term
end

When(/^I retrieve all enrollments for a mutant$/) do
  @response = MutantsAPIGem::Routes::Enrollments.retrieve_for_mutant(@mutant)
end

Then(/^the enrollments will be returned$/) do
  raise "List of mutants was not returned" unless @response.code == 200 && @response.is_a?(Array)
end

Given(/^A mutant is enrolled in a term$/) do
  @enrollment = MutantsAPIGem::Enrollment.new(@mutant, @term)
  @enrollment.create_for_term
  raise "Mutant didn't get enrolled into term" if @enrollment.id.nil?
end

When(/^I retrieve the enrollment$/) do
  @response = @enrollment.retrieve_for_mutant
end

Then(/^enrollment will be returned$/) do
  raise "Enrollment wasn't returned" unless @enrollment.id == @response["id"]
end

When(/^I retrieve all enrollments for a term$/) do
  @response = @enrollment.retrieve_for_term
end

Then(/^the enrollment will be created$/) do
  raise "Mutant didn't get enrolled into term" if @enrollment.id.nil?
end