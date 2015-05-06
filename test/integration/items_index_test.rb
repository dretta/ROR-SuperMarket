require 'test_helper'

class ItemsIndexTest < ActionDispatch::IntegrationTest
  
	def setup
		@item = items(:Ruby)
		@admin = users(:michael)
		@non_admin = users(:archer)
	end



	test "item index as admin including pagination and delete links" do
		log_in_as(@admin)

		get items_path
		assert_template 'items/index'
		assert_select 'div.pagination'
		first_page_of_items = Item.paginate(page: 1)
		first_page_of_items.each do |item|
			assert_select 'a[href=?]', item_path(item), text: item.name
			assert_select 'a[href=?]', item_path(item), text: 'delete', method: :delete
		end
		assert_difference 'Item.count', -1 do
			delete item_path(@item)
		end
	end


	test "item index as non-admin" do
		log_in_as(@non_admin)
		get items_path
		assert_select 'a', text: 'delete', count: 0
	end

end
