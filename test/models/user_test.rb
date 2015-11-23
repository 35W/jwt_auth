require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  #just a setup test
  test "basic" do 
    u = User.where( :email => "test@test.com" )
    assert u
  end
  
end
