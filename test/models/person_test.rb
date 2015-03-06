require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  test "should not save Person without gender" do
	  person = Person.create(gender: nil, height: 1, weight: 2)
	  assert person.valid?, "Person did not save"
  end

  test "should not save Person without gender being male or female" do
	  person = Person.create(gender: "girl", height: 1, weight: 2)
	  assert person.valid?, "Person did not save. Gender must be male or female"
  end

  test "should not save Person without height" do
	  person = Person.create(gender: "male", height: nil, weight: 2)
	  assert person.valid?, "Person did not save"
  end

  test "should not save Person without weight" do
	  person = Person.create(gender: "female", height: 1, weight: nil)
	  assert person.valid?, "Person did not save"
  end

  test "should save Person with all attributes" do
	  person = Person.create(gender: "male", height: 1, weight: 2)
	  assert person.valid?, "Person saved"
  end
end
