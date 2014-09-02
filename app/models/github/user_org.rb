class Github::UserOrg
  attr_reader :avatar_url, :login

  def initialize(user_or_org)
    @login = user_or_org.login
    @avatar_url = user_or_org.avatar_url
  end
end
