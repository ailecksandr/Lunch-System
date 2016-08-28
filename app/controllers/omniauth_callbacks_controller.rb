class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.find_for_google_oauth2(request.env['omniauth.auth'])
    login(user)
  end


  private


  def login(user)
    if user.persisted?
      sign_in user
      redirect_to root_url
    else
      redirect_to new_user_session_path
    end
  end
end
