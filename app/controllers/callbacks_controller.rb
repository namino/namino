class CallbacksController < ApplicationController
  def github
    auth = request.env['omniauth.auth']
    provider = Provider.find_by(name: auth['provider'], uid: auth['uid'])

    if provider.present?
      provider.token = auth['credentials']['token']
      provider.save

      sign_in_and_redirect(provider.user, event: :authentication)
    else
      session['devise.oauth_data'] = auth
      redirect_to new_user_registration_path
    end
  end
end
