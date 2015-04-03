require 'test_helper'

class ShoppingcartTest < ActiveSupport::TestCase

	def setup
		@user = users(:michael)
		@cart = @user.build_shoppingcart(size:1,total:1.00)
	end

	test "should be valid" do
		assert @cart.valid?
	end
		
	test "size should never be negative" do
		@cart.size = -1		
		assert_not @cart.valid?
	end

	test "total should never be negative" do
		@cart.total = -1.00
		assert_not @cart.valid?
	end
end
