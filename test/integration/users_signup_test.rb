require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invaild signup information"  do
  	get signup_path
  	assert_no_difference 'User.count' do
  		post users_path, params: { user: {
  			name: "",
  			email: "759337828@qq.com",
  			password: "foo", 
  			password_confirmation: "bar"
  		}}
  	end
  	assert_template 'users/new'

  	assert_select '#error_explanation', minimum: 1
  	assert_select '.field_with_errors', minimum: 1
  end

  test "valid signup information" do
  	get signup_path
  	assert_difference 'User.count', 1 do
  		post users_path, params: { user: {
  			name: "759337828",
  			email: "759337828@qq.com",
  			password: "759337828", 
  			password_confirmation: "759337828"
  		}}
  	end

  	follow_redirect!
  	assert_template 'users/show'
  	assert_not flash.empty?
  end
end
	