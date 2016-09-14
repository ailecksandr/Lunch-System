class MenusController < ApplicationController
  include ItemsHelper
  protect_from_forgery except: [:menu_details, :render_modal]

  load_and_authorize_resource class: 'Meal'
  before_action :authenticate_user!, except: :index

  def index
  end

  def form_today
  end

  def render_modal
    case params[:purpose]
    when 'meals'
      @type, @meal = params[:type], (params[:meal].present? ? Meal.find(params[:meal]) : nil)
    when 'items'
      @item = params[:item].present? ? Item.find(params[:item]) : nil
    end

    respond_to do |format|
      format.js { render "#{params[:purpose]}/render_modal.js.erb" }
    end
  end

  def menu_details
    @date = Time.parse(params[:date])
    respond_to :js
  end
end
