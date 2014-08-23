class Profile < ActiveRecord::Base
  validates :description, length: { maximum: 200 }
  validates :name,        length: { maximum: 20 }
end
