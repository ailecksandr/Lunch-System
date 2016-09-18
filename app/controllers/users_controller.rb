class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @users = User.worker.order(:nickname)
  end

  def token
    @access_token = ApiKey.actual.first_or_create.access_token
  end

  def clear_tokens
    ApiKey.inactive.destroy_all
    redirect_to root_url, notice: 'Successfully cleared'
  end
end
