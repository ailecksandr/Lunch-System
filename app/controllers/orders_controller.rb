class OrdersController < ApplicationController
  protect_from_forgery except: [:refresh_orders, :order_details]

  load_and_authorize_resource except: :create
  before_action :authenticate_user!
  before_action :get_date, only: [:refresh_orders, :destroy, :order_details]

  def create
    begin
      @order = Order.new(order_params)
      first_meal = Meal.find(params[:order][:first_meal])
      main_meal = Meal.find(params[:order][:main_meal])
      drink = Meal.find(params[:order][:drink])
      @order.save
      @order.menu_items.create(
          [
              { meal: first_meal },
              { meal: main_meal },
              { meal: drink }
          ]
      )
    rescue
      @error = true
    end

    if !@error
      flash[:success] = 'Successfully ordered'
    else
      flash[:danger] = 'Choose all meals'
    end

    redirect_to root_path
  end

  def index
    @orders = Order.up_to_date
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
    @orders = Order.up_to_date(@date)
  end


  private


  def order_params
    params.require(:order).permit(:user_id)
  end

  def get_date
    @date = (Date.parse(params[:date]) rescue Time.now)
  end
end
