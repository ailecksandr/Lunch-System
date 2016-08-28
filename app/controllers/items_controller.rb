class ItemsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :authenticate_user!
  before_action :find_item, except: [:index, :create]

  def index
    @food = Item.all.order(:name).paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Successfully removed'
  end

  def update
    if @item.update(item_params)
      redirect_to items_path, notice: 'Successfully updated'
    else
      flash[:danger] = 'Incorrect data'
      redirect_to items_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: 'Successfully added'
    else
      flash[:danger] = 'Incorrect data'
      redirect_to items_path
    end
  end


  private


  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :item_type)
  end
end
