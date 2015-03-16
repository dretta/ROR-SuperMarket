class Item < ActiveRecord::Base
	#attr_accessible :name, :description, :price
	validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
	validates :description, presence: true, 
		length: { maximum: 1000 }
	VALID_PRICE_REGEX = /\A\d+(?:\.\d{0,2})?\z/
	validates :price, presence: true, 
		:format => { with: VALID_PRICE_REGEX }, 
		:numericality => {:greater_than => 0}
end
