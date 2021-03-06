class Category < ActiveRecord::Base
  validates :name, presence: true
  has_many :topics, dependent: :delete_all
  has_many :permissions, as: :thing
  
  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view",
                                              user_id: user.id })
  end

  scope :for, ->(user) do
    user.admin? ? Category.all : Category.viewable_by(user)
  end
end
