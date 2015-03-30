require 'test_helper'

class ItemsControllerTest < ActionController::TestCase

	def setup
		@user       = users(:michael)
		@other_user = users(:archer)
	end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should redirect destroy when not admin" do
		assert_no_difference 'Item.count' do
			delete :destroy, id: @item
		end
		assert_redirected_to item_url
	end

	test "should redirect destroy when logged in as a non-admin" do
		log_in_as(@other_user)
		assert_no_difference 'Item.count' do
			delete :destroy, id: @item
		end
		assert_redirected_to item_url
	end

end
