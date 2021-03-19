class Chat < ApplicationRecord
  belongs_to :subject, polymorphic: true
  has_many :messages
  has_and_belongs_to_many :users, through: :messages
end
