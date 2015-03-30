require 'test_helper'

class ItemsCreateTest < ActionDispatch::IntegrationTest

	test "invalid item information" do
		get new_item_path
		assert_no_difference 'Item.count' do
		post items_path, item: { name:  "",
			description: "",
			price: 0.0}
	end
	assert_template 'items/new'
end

	test "valid item information" do
		get new_item_path
		assert_difference 'Item.count', 1 do
		post_via_redirect items_path, item: { 
			name:  "Example Item",
			description: "Some kind of Item",
			price: "1.00"}
		end
		assert_template 'items/show'
	end

end
