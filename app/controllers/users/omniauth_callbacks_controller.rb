class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def auth0
    # Extract user info from the OmniAuth auth hash
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Signed in successfully!"
    else
      redirect_to new_user_registration_url, alert: "Error signing in."
    end
  end

  def failure
    redirect_to root_path
  end
  
end
