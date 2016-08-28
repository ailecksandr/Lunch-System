class ItemsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :authenticate_user!
  before_filter :find_item, except: :index

  def index
    @food = Item.all.order(:name).paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  def update
    @item.update(item_params)
    redirect_to items_path
  end

  def create
    @item.save(item_params)
    redirect_to items_path
  end


  private


  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :item_type)
  end
end
