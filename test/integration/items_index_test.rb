require 'test_helper'

class ItemsIndexTest < ActionDispatch::IntegrationTest
  
	def setup
		@item = items(:Ruby)
	end

	test "index including pagination" do
		get items_path
		assert_template 'items/index'
		assert_select 'div.pagination'
		Item.paginate(page: 1).each do |item|
			assert_select 'a[href=?]', item_path(item), text: item.name
		end
	end

end
