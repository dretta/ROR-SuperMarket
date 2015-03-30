class ItemsController < ApplicationController
	before_filter :search_items
	before_action :admin_user,	only: :destroy
	
	def show
		@item = Item.find(params[:id])
		@current_user = current_user
		##debugger
	end

	def create 
		@item = Item.new(item_params) 
		if @item.save
			flash[:success] = "#{@item.name} has been successfully added!" 
			redirect_to @item 
		else 
			render 'new' 
		end 
	end


	def index
		@current_user = current_user

		# Index without React
		@items = Item.paginate(page: params[:page])
		
		# Index with React 
		#@items = Kaminari.paginate_array(Item.first(10)).page(params[:page])
	end


	def new
		@item = Item.new
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		if @item.update_attributes(item_params)
			flash[:success] = "Item updated"
			redirect_to @item
		else
			render 'edit'
		end
	end

	def destroy
		Item.find(params[:id]).destroy
		flash[:success] = "Item deleted"
		redirect_to items_url
	end

	private

		def item_params
			params.require(:item).permit(:name, :description, :price)
		end

		def admin_user
			redirect_to(root_url) unless @current_user.admin?
		end

		def search_items
			@item = if params[:search].present?
				Item.search(params[:search])
			else
				Item.all
			end.sorted.page(params[:page])
		end

end
