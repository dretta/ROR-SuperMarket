require 'test_helper'

class ItemsEditTest < ActionDispatch::IntegrationTest


  def setup
    @admin = users(:michael)
    @item = items(:Ruby)
  end

  test "unsuccessful item edit" do
    log_in_as(@admin)
    get edit_item_path(@item)
    assert_template 'items/edit'
    patch item_path(@item), item: { 
      name:  "",
      description: "",
      price: -1.00}
    assert_template 'items/edit'
  end

  test "successful item edit" do
    log_in_as(@admin)
    get edit_item_path(@item)
    assert_template 'items/edit'
    name  = "Some Item"
    description = "Looks like an item."
    price = 1.00
    patch item_path(@item), item: { 
      name:  name,
      description: description,
      price: price}
    assert_not flash.empty?
    assert_redirected_to @item
    @item.reload
    assert_equal @item.name,  name
    assert_equal @item.description, description
    assert_equal @item.price, price
  end

end