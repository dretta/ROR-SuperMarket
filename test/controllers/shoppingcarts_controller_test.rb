require 'test_helper'

class ShoppingcartsControllerTest < ActionController::TestCase
  
	def setup
		@user = users(:michael)
		log_in_as(@user)
	end


	test "should get show" do
		puts(@user.name)
		puts(@user.id)
		get :show
		assert_response :success
	end


end
