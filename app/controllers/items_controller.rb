class ItemsController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper

  load_and_authorize_resource
  before_action :authenticate_user!
  before_filter :find_item, only: :destroy

  def index
    smart_listing_create :users,
                         Item.all,
                         partial: 'items/list',
                         default_sort: { name: 'asc' }
  end

  def destroy
    @item.destroy
  end


  private


  def find_item
    @item = Item.find(params[:id])
  end
end
