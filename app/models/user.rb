class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :recoverable, :rememberable, :timeoutable, :validatable
  devise :confirmable, :database_authenticatable, :omniauthable,
         :registerable, :trackable

  has_one :profile
  has_one :provider

  validates :email,    presence: true, uniqueness: true, email: true
  validates :username, presence: true, uniqueness: true, length: { maximum: 20 },
                       format: { with: /\A[A-Za-z0-9_]+\z/ }


  # When encrypted_password field was deleted from db, Devise is occured an method missing error.
  # This method is defined to prevent it.
  def encrypted_password; end

  def build_relations(oauth)
    self.build_provider do |p|
      p.name  = oauth['provider']
      p.uid   = oauth['uid']
      p.token = oauth['credentials']['token']
    end

    self.build_profile do |p|
      p.avatar_url = oauth['info']['image']
    end

    self
  end
end
