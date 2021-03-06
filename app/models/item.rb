class Item < ActiveRecord::Base	
	include PgSearch
	belongs_to :shoppingcart
	has_many :users, through: :shoppingcart
	default_scope -> {order(created_at: :asc)}
	validates :name, presence: true, length: { maximum: 100 }
	validates :description, presence: true, 
		length: { maximum: 1000 }
	VALID_PRICE_REGEX = /\A\d+(?:\.\d{0,3})?\z/
	validates :price, presence: true, 
		:format => { with: VALID_PRICE_REGEX }, 
		:numericality => {:greater_than => 0}
	validates_uniqueness_of :name

	scope :sorted, ->{ order(name: :asc) }
	pg_search_scope :search,
                  against: [
                    :name,
                    :description,
                    :price
                  ],
                  using: {
                    tsearch: {
                      prefix: true,
                      normalization: 2
                    }
                  }


	def Item.priceMaker
		num = Faker::Commerce.price
		num = '%.2f' % num 
		return num		
	end

	def priceFormat
		"$#{sprintf("%.2f" , price)}"
	end 

	def Item.nameMaker
		name = ""
		loop do
			name = Faker::Commerce.product_name
#			puts "Name: #{name}"
			item = Item.find_by(name: name)
			if item.nil? 
#				puts "#{name} not found"
				break 
			end
		end	
#		puts "Returning Name #{name}"
		return name
	end

	def Item.newName
		Faker::Commerce.product_name
	end


	def Item.gen
		100.times {
			@itemN = Item.new 
			@itemN.description = "Some Item"
			@itemN.price = 100
			@itemN.name = Item.nameMaker
			puts "Saving #{@itemN.name}"
			@itemN.save!
		}
	end
end


