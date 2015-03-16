
require 'test_helper'

class ItemTest < ActiveSupport::TestCase

	def setup
		@item = Item.create(name: "Example Item", description: "Some kind of Item", price: 1.00)
		@item2 = Item.create(name: "Another Item", description: "Some kind of Item")
	end

	test "should be valid" do
		assert @item.valid?
	end

	test "name should be present" do
		@item.name = " "
		assert_not @item.valid?
	end

	test "description should be present" do
		@item.description = " "
		assert_not @item.valid?
	end
		
	test "price should be present" do
		@item.price = nil
		assert_not @item.valid?
	end		


	test "name should not be too long" do
		@item.name = "a" * 101
		assert_not @item.valid?
	end

	test "description should not be too long" do
		@item.description = "a" * 1001
		assert_not @item.valid?
	end

	test "price should not be less than a penny" do
		@item.price = 0.009
		assert_not @item.valid?
	end

	test "price should not be negative" do
		@item.price = -100.00
		assert_not @item.valid?
	end

	test "name should be unique" do
		dup_item2 = @item2.dup
		@item2.save
		assert_not dup_item2.valid? #works
		dup_item = @item.dup
		@item.save
		assert_not dup_item.valid? #fails
	end


end

=begin
require 'test_helper'

class ItemTest < ActiveSupport::TestCase

  def setup
    @item = Item.new(name: "Example Item", description: "Some kind of Item", price: 1.00)
  end

  test "name should be unique" do
    duplicate_item = @item.dup
    @item.save!
    duplicate_item.valid? # need this to populate errors
    assert duplicate_item.errors
    assert duplicate_item.errors[:name]
    Rails::logger.debug duplicate_item.errors.full_messages
  end
end
=end