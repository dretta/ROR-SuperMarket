class Shoppingcart < ActiveRecord::Base
	belongs_to :user
	has_many :items
	validates :user_id, presence: true
	validates :size, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
	validates :total, presence: true, :numericality => { :greater_than_or_equal_to => 0.00 }

	def initalize(s=0, t=0.00)
		self.size = s
		self.total = t
		self.user_id = uid 
	end
end
