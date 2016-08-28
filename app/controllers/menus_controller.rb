class MenusController < ApplicationController
  include ItemsHelper

  load_and_authorize_resource class: 'Meal', except: :index
  before_action :authenticate_user!, except: :index

  def index
  end

  def form_today
  end

  def menu_details
    @date = Time.parse(params[:date])
    respond_to :js
  end
end
