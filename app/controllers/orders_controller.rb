class OrdersController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :authenticate_user!

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
      flash[:success] = 'Succesfully ordered'
    else
      flash[:danger] = 'Choose all meals'
    end

    redirect_to root_path
  end

  def index
    @orders = Order.up_to_date
  end

  def order_details
    @order = Order.find(params[:id])
  end

  def refresh_orders
    @date = Date.parse(params[:date])
    @orders = Order.up_to_date(@date)
  end


  private


  def order_params
    params.require(:order).permit(:user_id)
  end
end
