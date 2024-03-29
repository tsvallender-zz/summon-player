class Post < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  has_rich_text :content
  validates :content, presence: true
end
