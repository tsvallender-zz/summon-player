class Post < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  validates :content,
    presence: true,
    length: { maximum: 5000 }
end
