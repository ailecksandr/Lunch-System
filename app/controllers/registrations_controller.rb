class RegistrationsController < Devise::RegistrationsController
  include AmazonModule

  load_and_authorize_resource class: 'User', only: [:edit, :update, :change_password]

  def update
    clear_s3_object(@user.avatar) unless @user.avatar.size.nil? || account_update_params['avatar'].nil?

    if @user.update(account_update_params)
      redirect_to edit_user_registration_path, notice: 'Successfully changed'
    else
      render 'devise/registrations/edit'
    end
  end

  def change_password
    @user = current_user
    if @user.update_with_password(password_params) && !password_params[:password].blank?
      bypass_sign_in @user
      flash[:notice] = 'Password has been changed successfully'
    else
      @user.errors.add(:password, t('activerecord.errors.models.user.attributes.password.blank')) if password_params[:password].blank?
    end
    render 'devise/registrations/edit'
  end

  private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:nickname, :avatar)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
