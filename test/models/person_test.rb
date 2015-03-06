require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "should not save Person without gender" do
	  person = Person.new
	  assert_not person.save
  end
end
