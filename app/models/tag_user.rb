class TagUser < ApplicationRecord
  belongs_to :tag
  belongs_to :user
  validates :user_id, presence: true
  validates :tag_id, presence: true
end
