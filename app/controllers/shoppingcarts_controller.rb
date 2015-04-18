class ShoppingcartsController < ApplicationController

	def new
		@user = User.find(params[:user_id])
		@shoppingcart = @user.build_shoppingcart
	end

	def show
		#@user = User.find(params[:user_id])
		@user = User.find(current_user.id)
		@shoppingcart = @user.build_shoppingcart
	end


	def create
		@user = User.find(current_user)
		@shoppingcart = Shoppingcart.find_by_user_id(@user)

		if @user_shoppingcart = @user.create_shoppingcart(user_params)
			redirect_to user_shoppingcart_url(@user,@user_shoppingcart)
		end
	end

end
