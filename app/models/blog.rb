class Blog < ActiveRecord::Base
  attr_accessor :originator

  validates :gh_login, presence: true
  validates :gh_repo_name, presence: true
  validates :title, presence: true
  validates :urlname, presence: true

  before_create :set_hook_key
  before_create :create_repo


  def repo
    "#{gh_login}/#{gh_repo_name}"
  end

  private

  def set_hook_key
    self.hook_key = SecureRandom.uuid
  end

  def create_repo
    if originator.providers.github.gh_login == gh_login
      originator.client.create_repository(gh_repo_name)
    else
      originator.client.create_repository(gh_repo_name, organization: gh_login)
    end

    create_contents
    create_hook
  end

  def create_contents
    contents = [
      {
        path: 'README.md',
        message: 'Add README',
        file: File.open('lib/sample/README.md')
      },
      {
        path: 'posts/hello-world.md',
        message: 'Add sample post file',
        file: File.open('lib/sample/posts/hello-world.md')
      },
      {
        path: 'posts/secret.md',
        message: 'Add sample secret post file',
        file: File.open('lib/sample/posts/secret.md')
      }
    ]

    contents.each do |c|
      originator.client.create_contents(repo, c[:path], c[:message], file: c[:file])
    end
  end

  def create_hook
    url = "#{ENV['GITHUB_HOOK_URL']}/api/hooks/#{hook_key}/receive"
    config = { url: url, content_type: 'json' }
    options = { events: ['push'], active: true }

    originator.client.create_hook(repo, 'web', config, options)
  end
end
