class ItemsController < ApplicationController

  def show
  	@item = Item.find(params[:id])
  	#debugger
  end

  def index
  	#@items = Item.paginate(page: params[:page])
  	@items = Item.all
  end

end
