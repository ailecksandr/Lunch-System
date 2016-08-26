class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @users = User.all.order(:nickname)
  end
end
