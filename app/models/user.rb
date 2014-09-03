class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :recoverable, :rememberable, :timeoutable, :validatable
  devise :confirmable, :database_authenticatable, :omniauthable,
         :registerable, :trackable

  has_many :blogs, through: :ownerships, dependent: :destroy
  has_many :ownerships, dependent: :destroy
  has_many :providers, dependent: :destroy
  has_one :profile, dependent: :destroy

  validates :email,    presence: true, uniqueness: true, email: true
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 },
                       format: { with: /\A[A-Za-z0-9_]+\z/ }


  # When encrypted_password field was deleted from db, Devise is occured an method missing error.
  # This method is defined to prevent it.
  def encrypted_password; end

  def build_relations(oauth)
    self.providers.new do |p|
      p.name = oauth['provider']
      p.gh_login = oauth['info']['nickname'] if oauth['provider'] == 'github'
      p.uid = oauth['uid']
      p.token = oauth['credentials']['token']
    end

    self.build_profile do |p|
      p.avatar_url = oauth['info']['image']
    end

    self
  end

  def client
    Octokit::Client.new(access_token: providers.github.token)
  end

  def user_orgs
    ary = []

    ary << Github::UserOrg.new(client.user)
    client.organizations.each do |org|
      ary << Github::UserOrg.new(org)
    end

    ary
  end
end
