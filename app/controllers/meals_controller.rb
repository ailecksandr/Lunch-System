class MealsController < ApplicationController
  load_and_authorize_resource except: :create
  before_action :authenticate_user!
  before_action :set_type

  def create
    @meal = Meal.new(meal_params)
    @meal.save
    respond_to :js
  end

  def update
    @meal = @meal.update(meal_params)
    respond_to :js
  end

  def destroy
    @meal.destroy
    respond_to :js
  end


  private


  def set_type
    @type = params[:type]
  end

  def meal_params
    params.require(:meal).permit(:price, :item_id)
  end
end
