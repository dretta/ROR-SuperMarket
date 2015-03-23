class ItemsController < ApplicationController
	before_filter :search_items

	def show
		@item = Item.find(params[:id])
	end


	def index

		# Index without React
		#@items = Item.paginate(page: params[:page])
		@items = Kaminari.paginate_array(Item.first(10)).page(params[:page])
		@current_user = current_user 

		render json: {
			items: @items,
			meta: {
				current_page: @items.current_page,
				next_page: @items.next_page,
				prev_page: @items.prev_page,
				total_pages: @items.total_pages,
				total_count: @items.total_count
			}
		}
	end


  def new

  end

	private
		def search_items
			@item = if params[:search].present?
				Item.search(params[:search])
			else
				Item.all
			end.sorted.page(params[:page])
		end

end
