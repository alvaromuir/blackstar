class Topic < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :title, presence: true
  validates :description, presence: true, length: { minimum: 10 }
  mount_uploader :asset, AssetUploader
end