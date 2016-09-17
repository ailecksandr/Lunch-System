class OrdersController < ApplicationController
  protect_from_forgery except: [:refresh_orders, :order_details]

  load_and_authorize_resource except: :create
  before_action :authenticate_user!
  before_action :get_date, only: [:refresh_orders, :destroy, :order_details]

  def create
    @order = Order.new(order_params)

    if @order.save
      flash[:success] = 'Successfully ordered'
    else
      flash[:danger] = 'Choose all meals'
    end

    redirect_to root_path
  end

  def index
    @orders = Order.includes(:user, :first_meal, :main_meal, :drink).up_to_date
  end

  def destroy
    @order.update(status: 'closed')
    @orders = Order.up_to_date(@date)

    respond_to do |format|
      format.js { render 'orders/refresh_orders' }
    end
  end

  def order_details
    @order = Order.find(params[:id])
  end

  def refresh_orders
    @orders = Order.includes(:user, :first_meal, :main_meal, :drink).up_to_date(@date)
  end


  private


  def order_params
    params.require(:order).permit(:user_id, :first_meal_id, :main_meal_id, :drink_id)
  end

  def get_date
    @date = (Date.parse(params[:date]) rescue Time.now)
  end
end
