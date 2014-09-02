class Blog < ActiveRecord::Base
  attr_accessor :originator

  validates :gh_login, presence: true
  validates :gh_repo_name, presence: true
  validates :title, presence: true
  validates :urlname, presence: true

  before_create :create_repo


  private

  def create_repo
    if originator.providers.github.gh_login == gh_login
      originator.client.create_repository(gh_repo_name)
    else
      originator.client.create_repository(gh_repo_name, organization: gh_login)
    end
  end
end
