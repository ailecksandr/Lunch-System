class MealsController < ApplicationController
  protect_from_forgery except: :render_modal

  load_and_authorize_resource except: :create
  before_action :authenticate_user!
  before_action :set_type

  def create
    @meal = Meal.new(meal_params)
    @meal.save
    @meals = Meal.eager.up_to_date.send(@type).sorted
    respond_to :js
  end

  def update
    @meal = @meal.update(meal_params)
    @meals = Meal.eager.up_to_date.send(@type).sorted
    respond_to :js
  end

  def destroy
    @meal.destroy
    @meals = Meal.eager.up_to_date.send(@type).sorted
    respond_to :js
  end

  def render_modal
    @meal = (params[:id].present? ? Meal.find(params[:id]) : nil)
    respond_to :js
  end


  private


  def set_type
    @type = params[:type]
  end

  def meal_params
    params.require(:meal).permit(:name, :price, :meal_type)
  end
end
