class Group < ApplicationRecord
  belongs_to :user
  has_many :group_users, dependent: :destroy
  has_many :members, :through => :group_users
end
