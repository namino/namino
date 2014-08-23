class RegistrationsController < Devise::RegistrationsController
  before_filter :set_oauth, only: [:new, :create]

  def new
    @user = User.new do |u|
      username = @oauth['info']['nickname']
      email    = @oauth['info']['email']
    end
  end

  def create
    @user = User.new(user_params).build_relations(@oauth)

    if @user.save
      flash[:info] = 'Thank you for registration! Confirmation mail has sent.'
      respond_with @user, location: root_path
    else
      render 'new'
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :username)
  end

  def set_oauth
    @oauth = session['devise.oauth_data']
  end
end
