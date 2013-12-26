class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :topics, dependent: :delete_all
end
