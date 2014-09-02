class Provider < ActiveRecord::Base
  belongs_to :user


  def self.github
    find_by(name: 'github')
  end

  def github?
    name == 'github'
  end
end
